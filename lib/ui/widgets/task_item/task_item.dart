import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/helpers.dart';

import '../../../controllers/controllers.dart';
import '../../../globals/globals.dart';
import '../../../globals/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../widgets.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({required this.task});

  final Task task;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final _textController = TextEditingController();
  bool _hasText = false;

  void _updateTextField() {
    setState(() {
      _hasText = _textController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateTextField);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final taskTileState = watch(taskTileProvider(widget.task));
        final tileStatus = taskTileState.status;
        final tileController = watch(taskTileProvider(widget.task).notifier);
        final tasksController = watch(tasksProvider.notifier);
        final settings = watch(settingsControllerProvider);
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                    value: widget.task.isDone,
                    onChanged: (value) {
                      final updatedTask = widget.task.copyWith(
                        isDone: value,
                        doneTime: DateTime.now().millisecondsSinceEpoch,
                      );
                      tasksController.update(task: updatedTask);
                    },
                  ),
                ),
                Expanded(
                  child: tileStatus == TaskTileStateStatus.editName
                      ? CupertinoTextField(
                          controller: _textController,
                          autofocus: true,
                          // style: Theme.of(context).textTheme.subtitle1,
                          onSubmitted: _hasText
                              ? (value) {
                                  final updatedTask = widget.task.copyWith(
                                    name: value.trim(),
                                  );
                                  tasksController.update(task: updatedTask);
                                  tileController.collapseTile();
                                }
                              : null,
                        )
                      : InkWell(
                          onTap: () {
                            _textController.text = widget.task.name;
                            tileController.showNameEditing();
                          },
                          child: Text(
                            widget.task.name,
                            style: CustomStyle.textStyleTaskName,
                          ),
                        ),
                ),
                CustomIconButton(
                  icon: tileStatus == TaskTileStateStatus.expanded
                      ? const Icon(Icons.arrow_drop_up)
                      : const Icon(Icons.arrow_drop_down),
                  color: Colors.transparent,
                  onPressed: tileStatus == TaskTileStateStatus.expanded
                      ? tileController.collapseTile
                      : tileController.expandTile,
                )
              ],
            ),
            if (settings.showDoneTime &&
                widget.task.isDone &&
                widget.task.doneTime != null)
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  Text('${s.completed}: ${TimeConversion.millisToDateAndTime(
                    widget.task.doneTime!,
                    dateFormat: settings.dateFormat,
                    timeFormat: settings.timeFormat,
                  )}'),
                ],
              ),
            AnimatedContainer(
              height: tileStatus == TaskTileStateStatus.expanded ? 140 : 0,
              duration: const Duration(milliseconds: 120),
              child: tileStatus == TaskTileStateStatus.expanded
                  ? Container()
                  : null,
            ),
            AnimatedContainer(
              height: tileStatus == TaskTileStateStatus.editName ? 56 : 0,
              duration: const Duration(milliseconds: 90),
              child: (tileStatus == TaskTileStateStatus.editName)
                  ? Row(
                      children: [
                        const SizedBox(width: 10),
                        SimpleButton(
                          onPressed: tileController.collapseTile,
                          text: s.cancel,
                        ),
                        const Spacer(),
                        SimpleButton(
                          text: s.save,
                          color: Colors.green,
                          onPressed: _hasText
                              ? () {
                                  final updatedTask = widget.task.copyWith(
                                    name: _textController.text.trim(),
                                  );
                                  tasksController.update(task: updatedTask);
                                  tileController.collapseTile();
                                }
                              : null,
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  : null,
            ),
            Container(
              height: 1,
              color: const Color(0xFFE0E0E0),
            ),
          ],
        );
      },
    );
  }
}
// class _TaskOptions extends StatelessWidget {
//   const _TaskOptions({
//     Key? key,
//     required this.task,
//     required this.onDeletePressed,
//     required this.onCategorySelected,
//     required this.onDateSelected,
//   }) : super(key: key);
//
//   final Task task;
//   final VoidCallback onDeletePressed;
//   final VoidCallback onCategorySelected;
//   final VoidCallback onDateSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 const SizedBox(width: 6),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Text(s.category),
//                     ),
//                     CategorySelector(
//                       task: task,
//                       onCategorySelected: onCategorySelected,
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Text(dueDate),
//                     ),
//                     DueDateSelector(
//                       task: task,
//                       onDateSelected: onDateSelected,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 6),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             SimpleButton(
//               text: delete,
//               color: Colors.red,
//               onPressed: onDeletePressed,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
