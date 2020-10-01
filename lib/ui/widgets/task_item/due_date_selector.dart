import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';

class DueDateSelector extends StatelessWidget {
  final Task task;

  const DueDateSelector({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: PopupMenuButton(
        tooltip: CHANGE_FORMAT,
        onSelected: (item) => print(item),
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(
            PopupMenuItem(
              child: Text(TODAY),
              value: 0,
            ),
          );
          list.add(
            PopupMenuItem(
              child: Text(TOMORROW),
              value: 1,
            ),
          );
          list.add(
            PopupMenuItem(
              child: Text(CUSTOM_DATE),
              value: 2,
            ),
          );
          list.add(
            PopupMenuItem(
              child: Text(NO_DATE),
              value: 3,
            ),
          );
          return list;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            task.dueDate.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
