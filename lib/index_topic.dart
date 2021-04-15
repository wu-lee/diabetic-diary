import 'package:diabetic_diary/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'translation.dart';

class IndexTopic<T extends Indexable> implements Topic, Indexable {
  final List<T> items;

  @override
  Symbol name;

  @override
  IconData icon;

  IndexTopic({this.name, this.items, this.icon});

  Widget buildWidget(BuildContext context) => ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: items.length*2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return new Text(TL8(items[index].name));
      }
  );
}
