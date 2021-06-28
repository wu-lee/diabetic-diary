import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database.dart';
import 'indexable.dart';
import 'entities/ingredient.dart';
import 'topic.dart';
import 'translation.dart';



abstract class EntityTopic<Entity extends Indexable> implements Topic {
  @override
  final Symbol id;

  @override
  final IconData icon;

  final AsyncDataCollection<Entity> entities;

  EntityTopic({required this.id, required this.icon, required this.entities});
}


