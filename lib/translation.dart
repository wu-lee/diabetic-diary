

/// Translate a symbol in the given context into a string in the target language
/// (as defined elsewhere)
String TL8(Symbol symbol, [dynamic context = null]) { // ignore: avoid_init_to_null
  // Stopgap implementation: toString returns 'Symbol("name here")', snip off the
  // boilerplate
  return symbolToString(symbol);
}

String symbolToString(Symbol symbol) {
  final string = symbol.toString();
  return string.substring(8, string.length-2);
}
