

import 'labels.dart';

/// Translate a symbol in the given context into a string in the target language
/// (as defined elsewhere)
String TL8(Symbol symbol, [Map<Symbol, dynamic> params = const {}]) {
  final translations = LABELS[symbol];
  if (translations == null)
    return symbolToString(symbol);

  final translation = translations[#en]; // FIXME unhardwire!
  if (translation == null)
    return symbolToString(symbol); // Make a best effort

  return translation.replaceAllMapped(RegExp(r'%\{(.+?)\}'),
          (match) => params[Symbol('${match[1]}')]?.toString() ?? '${match[0]}');
}

String symbolToString(Symbol symbol) {
  final string = symbol.toString();
  return string.substring(8, string.length-2);
}
