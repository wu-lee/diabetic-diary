import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

const lineNumber = 'line-number';

void main(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser(); //..addFlag(lineNumber, negatable: false, abbr: 'n');

  ArgResults argResults = parser.parse(arguments);
  if (argResults.rest.length < 1)
    throw ArgumentError("You must supply the path to the labels.tsv file");

  final path = argResults.rest.first;

  final file = File(path);
  if (!await file.exists())
    throw ArgumentError("No such file $path");

  final lines = file.readAsLinesSync();
  final header = lines.first.split("\t");
  final langCodes = header.skip(1).map((lc) => lc.toLowerCase()).toList();

  final labels = lines.skip(1).map((element) {
    final fields = element.split("\t");
    final id = fields.first;
    final phrases = fields.skip(1).toList();
    final labelDef = Iterable.generate(langCodes.length, (ix) =>
        ix < phrases.length?
        "#${langCodes[ix]}: '${phrases[ix]}'," :
        "// #${langCodes[ix]}: '',"
    );
    return "  #$id: {\n    ${labelDef.join("\n    ")}\n  },";
  });

  print("""

const LABELS = {
${labels.join("\n")}
};
""");
}