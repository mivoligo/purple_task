import 'package:flutter/material.dart';
import 'package:purple_task/models/models.dart';
import '../../../../globals/globals.dart';
import '../../../../globals/strings/strings.dart' as s;

import '../../../ui.dart';
import 'new_category_base.dart';

class CategoryTasks extends StatelessWidget {
  CategoryTasks({
    Key? key,
    required this.tasks,
    required this.name,
    required this.color,
    required this.onAddTask,
    required this.onNext,
    required this.onCancel,
    required this.selectedIcon,
    required this.focusNode,
  }) : super(key: key);

  final List<Task> tasks;
  final String name;
  final Color color;
  final Function(String) onAddTask;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int selectedIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      onCancel: onCancel,
      okButtonText: s.finish,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 32.0, 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      IconData(
                        selectedIcon,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      color: color,
                      size: 38,
                    ),
                  ),
                  Text(
                    name,
                    style: CustomStyle.textStyleBigName,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
                child: AddTaskField(
                  addTask: onAddTask,
                )),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                s.taskSingularCapital,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
                child: Scrollbar(
                  child: ListView.separated(
                    // controller: _scrollController,
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 6.0),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text(tasks[index].name),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
