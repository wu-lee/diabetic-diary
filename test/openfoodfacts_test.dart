import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/UserAgent.dart';
import 'package:openfoodfacts/model/parameter/TagFilter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/OpenFoodAPIConfiguration.dart';
import 'package:test/test.dart';

String formatIngredients(List<Ingredient>? ingredients) {
  if (ingredients == null)
    return "  -";
  return ingredients
      .where((e) => e.id?.startsWith("en:") == true)
      .map((i) => "    ${i.id?.substring(3).replaceAll('-', ' ')} (${i.text})")
      .join("\n");
}

class NutrimentInfo {
  NutrimentInfo({this.modifier, this.amount});
  String? modifier;
  num? amount;
}

const RELEVANT_NUTRIMENTS = {
  'alcohol': #per_cent,
  'caffeine': #g_per_hg,
  'calcium': #g_per_hg,
  'carbohydrates': #g_per_hg,
  'energy-kj': #kj_per_hg,
  'energy-kcal': #kcal_per_hg,
  'fat': #g_per_hg,
  'fiber': #g_per_hg,
  'proteins': #g_per_hg,
  'salt': #g_per_hg,
  'saturated-fat': #g_per_hg,
  'sodium': #g_per_hg,
  'sugars': #g_per_hg,
};

String formatNutriments(Nutriments? nutriments) {
  if (nutriments == null)
    return "  -";
  final Map<String,  NutrimentInfo> info = {};
  final nutrimentsJson = nutriments.toJson();
  nutriments.toJson().forEach((key, value) {
    final components = key.split('_');
    if (components.length < 2)
      return;
    if (!RELEVANT_NUTRIMENTS.containsKey(components[0]))
      return;
    NutrimentInfo ni = info.putIfAbsent(components[0], () => NutrimentInfo());
    switch(components[1]) {
      case "100g":
        ni.amount = value;
        break;
      case "modifier":
        ni.modifier = value;
        break;
    }
  });
// FIXME - ignore items with modifier?
  // FIXME alchohol - pc by vol?
  return info.keys
    .toList()
    //..sort()
    .map((k) => "    $k: ${info[k]?.modifier ?? ""}${info[k]?.amount}")
    .join("\n");
;
}

String format(Product e) {
  return """
${e.productName} (${e.barcode})
  Ingredients:
${formatIngredients(e.ingredients)}
  Nutriments:
${formatNutriments(e.nutriments)}

""";
}

void main() async {

  test("test", () async {
    var parameters = <Parameter>[
      const Page(page: 1),
      const PageSize(size: 10),
      const SortBy(option: SortOption.POPULARITY),
      const TagFilter(
          tagType: "categories",
          contains: true,
          tagName: "breakfast_cereals"),
      const TagFilter(
          tagType: "states", contains: true, tagName: "en:complete")
    ];

    ProductSearchQueryConfiguration configuration =
    ProductSearchQueryConfiguration(
        parametersList: parameters,
        fields: [ProductField.NAME, ProductField.BARCODE, ProductField.INGREDIENTS, ProductField.NUTRIMENTS],
        language: OpenFoodFactsLanguage.ENGLISH);
    OpenFoodAPIConfiguration.userAgent =
        UserAgent(
            name: 'openfoodfacts_test.dart',
            //version: '',
            system:'',
            url: 'https://github.com/wu-lee/diabetic-diary/',
            comment:'Diabetic Diary test script'
        );
    SearchResult result = await OpenFoodAPIClient.searchProducts(
        null, configuration);

    print("result ${result.products?.map((p) => format(p)).join("\n")}");
  });
}

class TestConstants {
}