import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LogPageState();
  }

}

class _LogPageState extends State<LogPage> {

  final _list = ["foo", "bar", "baz"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _list.length*2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          return new Text("hello ${_list[index]}");
        });
  }
}