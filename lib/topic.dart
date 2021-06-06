

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'translation.dart';

class Topic implements Indexable {
  final Symbol id;

  final IconData icon;

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return null; // No button
  }

  Topic({this.id, this.icon});

  Widget buildTabContent(BuildContext context) => Center(child: Text(TL8(id)));
}

