

const Translations = <Symbol, String>{
  #YouHaveNDishes: "You have %{n} dishes",
  #YouHaveNIngredients: "You have %{n} ingredients",
  #YouHaveNMacroNutrients: "You have %{n} macro nutrients",
};


/// Translate a symbol in the given context into a string in the target language
/// (as defined elsewhere)
String TL8(Symbol symbol, [Map<Symbol, dynamic> params = const {}]) {
  final translation = Translations[symbol];
  if (translation != null)
    return translation.replaceAllMapped(RegExp(r'%\{(.+?)\}'),
            (match) => params[Symbol('${match[1]}')]?.toString() ?? '${match[0]}');
  // Stopgap implementation: toString returns 'Symbol("name here")', snip off the
  // boilerplate
  return symbolToString(symbol);
}

String symbolToString(Symbol symbol) {
  final string = symbol.toString();
  return string.substring(8, string.length-2);
}
