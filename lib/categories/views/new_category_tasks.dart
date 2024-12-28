import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/strings/strings.dart' as s;
import '../../tasks/models/task.dart';
import '../../ui/widgets/widgets.dart';
import 'new_category_base.dart';

class NewCategoryTasks extends StatefulWidget {
  NewCategoryTasks({
    Key? key,
    required this.tasks,
    required this.name,
    required this.color,
    required this.onAddTask,
    required this.onNext,
    required this.selectedIcon,
    required this.focusNode,
  }) : super(key: key);

  final List<Task> tasks;
  final String name;
  final Color color;
  final Function(String) onAddTask;
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
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 32.0, 4.0),
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
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
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
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: widget.tasks.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 6.0),
                    itemBuilder: (context, index) {
                      final reversedList = widget.tasks.toList();
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(reversedList[index].name),
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
