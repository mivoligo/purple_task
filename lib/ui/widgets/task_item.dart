import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String name;
  final bool isDone;
  final VoidCallback onMenuPressed;
  final Function onCheckboxChanged;

  const TaskItem({
    Key key,
    this.name,
    this.isDone,
    this.onMenuPressed,
    this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Text(name),
      leading: Checkbox(
        value: isDone,
        onChanged: onCheckboxChanged,
      ),
      trailing: IconButton(
        icon: Icon(AntIcons.menu),
        onPressed: onMenuPressed,
      ),
    );
  }
}
