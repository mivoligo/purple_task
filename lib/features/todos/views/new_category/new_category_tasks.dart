import 'package:flutter/material.dart';

import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/features/todos/views/add_task_field.dart';
import 'package:purple_task/features/todos/views/new_category/new_category_base.dart';

class NewCategoryTasks extends StatefulWidget {
  const NewCategoryTasks({
    required this.tasksNamesList,
    required this.name,
    required this.color,
    required this.onAddTask,
    required this.onNext,
    required this.selectedIcon,
    required this.focusNode,
    super.key,
  });

  final List<String> tasksNamesList;
  final String name;
  final Color color;
  final void Function(String) onAddTask;
  final VoidCallback onNext;
  final int selectedIcon;
  final FocusNode focusNode;

  @override
  _NewCategoryTasksState createState() => _NewCategoryTasksState();
}

class _NewCategoryTasksState extends State<NewCategoryTasks> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: widget.focusNode,
      color: widget.color,
      onNext: widget.onNext,
      okButtonText: s.finish,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 32, 4),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      IconData(
                        widget.selectedIcon,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      color: widget.color,
                      size: 38,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: CustomStyle.textStyle24,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 4),
              child: AddTaskField(
                onAddTask: (value) {
                  widget.onAddTask(value);
                  setState(() {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 100,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.linear,
                    );
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                s.taskSingularCapital,
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.tasksNamesList.isEmpty)
              const Padding(
                padding: EdgeInsets.all(36),
                child: Center(child: Text(s.newCategoryTasksInfo)),
              ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: widget.tasksNamesList.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 6),
                    itemBuilder: (context, index) {
                      final tasksNamesList = widget.tasksNamesList;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(tasksNamesList[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
