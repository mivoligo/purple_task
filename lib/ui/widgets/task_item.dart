import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String name;
  final bool isDone;
  final Function onChanged;

  const TaskItem({
    Key key,
    this.name,
    this.isDone,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(name),
      value: isDone,
      onChanged: onChanged,
    );
  }
}
