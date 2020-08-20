import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/widgets/add_task_field.dart';

class CategoryTasks extends StatelessWidget {
  final Function onFinishPressed;

  const CategoryTasks({
    Key key,
    @required this.onFinishPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 0.0),
          child: Consumer<NewCategory>(
            builder: (_, value, __) => Text(
              value.name,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
          child: AddTaskField(
            addTask: () => Provider.of<NewCategory>(context, listen: false)
                .addTask(context),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          TASK_SINGULAR_CAPITAL,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Consumer<NewCategory>(
            builder: (_, value, __) => ListView.builder(
              itemCount: value.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                  title: Text(value.tasks[index].name),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(width: 16.0),
            FlatButton(
              color: Colors.grey[400],
              child: Text(CANCEL),
              onPressed: () {
                Provider.of<NewCategory>(context, listen: false)
                    .addingNewCategoryCompleted = false;
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            FlatButton(
              autofocus: true,
              color: Colors.green,
              child: Text(FINISH),
              onPressed: onFinishPressed,
            ),
            SizedBox(width: 16.0),
          ],
        )
      ],
    );
  }
}
