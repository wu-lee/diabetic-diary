

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'translation.dart';

class Topic implements Indexable {
  final Symbol id;

  final IconData icon;

  Topic({required this.id, required this.icon});

  Widget buildTabContent(BuildContext context) => Center(child: Text(TL8(id)));
}

