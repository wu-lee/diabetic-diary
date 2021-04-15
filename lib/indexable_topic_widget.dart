import 'package:flutter/widgets.dart';

import 'index_topic.dart';
import 'indexable.dart';
import 'topic.dart';

class IndexTopicWidget extends StatefulWidget {
  final Topic topic;
  IndexTopicWidget({Key key, this.topic}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndexTopicState(topic);
}

class _IndexTopicState<T extends Indexable> extends State<IndexTopicWidget> {
  final IndexTopic<T> index;

  _IndexTopicState(this.index);

  @override
  Widget build(BuildContext context) => index.buildWidget(context);
}
