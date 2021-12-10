import 'package:diabetic_diary/measureable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openfoodfacts/model/parameter/Page.dart' as OFF;
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/model/parameter/TagFilter.dart';
import 'package:openfoodfacts/model/UserAgent.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/OpenFoodAPIConfiguration.dart';

import 'basic_ingredient.dart';
import 'quantity.dart';
import 'units.dart';


// Used to aggregate OFF search results
class OffNutrimentInfo {
  OffNutrimentInfo({this.modifier, this.amount});
  String? modifier;
  num? amount;
}

/// Convert a [label]/nutriment [info] pair into an amount of 
/// for the [Measurable] corresponding to that nutriment.
///
/// Or if no amount should be recorded, returns null.
/// 
/// All amounts returned should be in kcal/100g for energy, or g/100g for
/// anything else.
typedef num? OffConversion(String label, Map<String, OffNutrimentInfo> info);

class OpenFoodFactsSearchDialog extends StatelessWidget {
  static OffConversion fromGramsPerHectogram = (label, info) => info[label]?.amount;
  static OffConversion fromEnergyProps = (label, info) =>
    info['energy-kcal']?.amount ?? info['energy-kj']?.amount ?? null;
  // FIXME above assumes both in kcal/100g
  // https://github.com/openfoodfacts/api-documentation/issues/51

  static final relevantNutriments = <String, MapEntry<Measurable, OffConversion>>{
    // FIXME alcohol - pc by vol?
//    'alcohol': Units.Percent,
    'caffeine': MapEntry(Measurable.Caffeine, fromGramsPerHectogram),
    'carbohydrates': MapEntry(Measurable.Carbs, fromGramsPerHectogram),
    'energy-kj': MapEntry(Measurable.Energy, fromEnergyProps),
    'energy-kcal': MapEntry(Measurable.Energy, fromEnergyProps),
    'fat': MapEntry(Measurable.Fat, fromGramsPerHectogram),
    'fiber': MapEntry(Measurable.Fibre, fromGramsPerHectogram),
    'proteins': MapEntry(Measurable.Protein, fromGramsPerHectogram),
    'salt': MapEntry(Measurable.Salt, fromGramsPerHectogram),
    'saturated-fat': MapEntry(Measurable.SaturatedFat, fromGramsPerHectogram),
    'sodium': MapEntry(Measurable.Sodium, fromGramsPerHectogram),
    'sugars': MapEntry(Measurable.Sugar, fromGramsPerHectogram),
  };

  static UserAgent userAgent = OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'OpenFoodFactsSearchDialog',
    //version: '',
    //system: '',
    url: 'https://github.com/wu-lee/diabetic-diary/',
    comment:'Diabetic Diary ingredient lookup'
  );

  static Future<BasicIngredient?> show(
      {required BuildContext context, required String searchTerms}) async {
    return showDialog<BasicIngredient>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) =>
          OpenFoodFactsSearchDialog(
            searchTerms: searchTerms,
          ),
    );
  }

  final String searchTerms;

  OpenFoodFactsSearchDialog({
    required this.searchTerms,
  });

  Future<SearchResult> searchOfn() {
    var parameters = <Parameter>[
      SearchTerms(terms: searchTerms.split(r'\s+')),
      const OFF.Page(page: 1),
      const PageSize(size: 50),
      const SortBy(option: SortOption.POPULARITY),
      const TagFilter(
          tagType: "states", contains: true, tagName: "en:nutrition-facts-completed")
    ];

    ProductSearchQueryConfiguration configuration =
    ProductSearchQueryConfiguration(
        parametersList: parameters,
        fields: [
          ProductField.NAME,
          ProductField.BARCODE,
          ProductField.INGREDIENTS,
          ProductField.NUTRIMENTS
        ],
        language: OpenFoodFactsLanguage.ENGLISH);

    return OpenFoodAPIClient.searchProducts(null, configuration);
  }

  Future<List<Product>> getProducts() async {
    SearchResult result = await searchOfn();
    final products = result.products;
    if (products == null)
      return [];
    else
      return products;
  }

  BasicIngredient convertOfnIngredient(Product product) {
    final Symbol id = Symbol(
        (product.productName ?? '').replaceAll(
            r'\s+', '')); // FIXME use barcode

    final nutriments = product.nutriments;
    final Map<String, OffNutrimentInfo> info = {};
    if (nutriments == null) {
      return BasicIngredient(id: id, contents: {});
    }
    nutriments.toJson().forEach((key, value) {
      final components = key.split('_');
      if (components.length < 2)
        return;
      final label = components[0];
      final nutriment = relevantNutriments[label];
      if (nutriment == null)
        return;
      OffNutrimentInfo ni = info.putIfAbsent(label, () => OffNutrimentInfo());
      switch (components[1]) {
        case "100g":
          ni.amount = value;
          break;
        case "modifier":
          ni.modifier = value;
          break;
      }
    });

    // Ignore items with a modifier, or no quantity
    info.removeWhere((label, ni) {
      if (ni.modifier != null) {
        debugPrint("ignoring ${ni.modifier} modified amount of $label in ${product.productName}");
        return true;
      }
      if (ni.amount == null) {
        debugPrint("ignoring empty amount of $label in ${product.productName}");
        return true;
      }
      return false;
    });

    // Convert to a contents map
    final contents = relevantNutriments.entries
        .map((elem) {
          final label = elem.key;
          final measurable = elem.value.key;
          return MapEntry(measurable, elem.value.value.call(label, info));
        })
        .where((elem) => elem.value != null)
        .map((elem) => MapEntry(elem.key.id, Quantity(elem.value!, elem.key.defaultUnits)));


  return BasicIngredient(id: id, contents: Map.fromEntries(contents));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Product>>(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot<Iterable<Product>> snapshot) {
          final Iterable<Product> products = snapshot.hasData? snapshot.data! : [];
          if (snapshot.hasError) {
            return _buildDialog(context, products, "search failed: ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return _buildDialog(context, products);
          }
          // Waiting
          return _buildDialog(context, products, "searching....");
        }
    );
  }

  Widget _buildDialog(BuildContext context, Iterable<Product> products, [Object? error]) {
    final content = error != null? [Text(error.toString())] :
                    products.length == 0? [Text("no matches...")] :
      products.map((product) =>
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, convertOfnIngredient(product));
            },
            child: Text(product.productName ?? "barcode ${product.barcode}"),
          )
      ).toList();

    return SimpleDialog(
      title: Text("Search OpenFoodFacts"),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: content,
        )
      ],
    );
  }
}
