import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'indexable.dart';
import 'entities/ingredient.dart';
import 'topic.dart';
import 'translation.dart';



abstract class EntityTopic<Entity extends Indexable> implements Topic {
  @override
  final Symbol name;

  @override
  final IconData icon;

  final List<Entity> entities;

  EntityTopic({this.name, this.icon, this.entities});
}


