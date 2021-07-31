

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'translation.dart';

class Topic implements Indexable {
  final Symbol id;

  final IconData icon;

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        // Do nothing
      },
      tooltip: 'Dummy',
    );
  }

  Topic({required this.id, required this.icon});

  Widget buildTabContent(BuildContext context) => Center(child: Text(TL8(id)));
}

