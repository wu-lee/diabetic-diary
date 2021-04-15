

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'translation.dart';

class Topic implements Indexable {
  final Symbol name;

  IconData icon;

  Topic({this.name, this.icon});

  Widget buildWidget(BuildContext context) => Text(TL8(name));
}

