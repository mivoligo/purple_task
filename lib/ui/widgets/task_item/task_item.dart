import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/widgets/task_item/task_item_delete.dart';
import 'package:to_do/ui/widgets/task_item/task_item_edit.dart';
import 'package:to_do/ui/widgets/task_item/task_item_normal.dart';

enum TaskState {
  Normal,
  EditName,
  ConfirmDelete,
}

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TaskState _taskState = TaskState.Normal;

  Widget buildTaskItem() {
    switch (_taskState) {
      case TaskState.Normal:
        return TaskItemNormal(
          task: widget.task,
          onDeletePressed: setTaskDelete,
          onNamePressed: setTaskEdit,
        );
        break;
      case TaskState.EditName:
        return TaskItemEdit(
          task: widget.task,
          onCancel: setTaskNormal,
          onSave: setTaskNormal,
        );
        break;
      case TaskState.ConfirmDelete:
        return TaskItemDelete(
          task: widget.task,
          onCancel: setTaskNormal,
          onDelete: setTaskNormal,
        );
        break;
    }
    return TaskItemNormal(task: widget.task);
  }

  setTaskNormal() {
    setState(() {
      _taskState = TaskState.Normal;
    });
  }

  setTaskDelete() {
    setState(() {
      _taskState = TaskState.ConfirmDelete;
    });
  }

  setTaskEdit() {
    setState(() {
      _taskState = TaskState.EditName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: buildTaskItem(),
    );
  }
}

//class NormalTaskItem extends StatefulWidget {
//  final Task task;
//
//  const NormalTaskItem({Key key, this.task}) : super(key: key);
//
//  @override
//  _NormalTaskItemState createState() => _NormalTaskItemState();
//}

//class _NormalTaskItemState extends State<NormalTaskItem> {
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      contentPadding: EdgeInsets.all(0.0),
//      title: Text(
//        widget.task.name,
//        style: TextStyle(
//          color: widget.task.isDone ? Colors.grey : Colors.black,
//          decoration: widget.task.isDone ? TextDecoration.lineThrough : null,
//        ),
//      ),
//      leading: Checkbox(
//        activeColor: Colors.grey,
//        value: widget.task.isDone,
//        onChanged: (value) {
//          setState(() {
//            widget.task.isDone = value;
//            Provider.of<TaskViewModel>(context, listen: false)
//                .updateTask(widget.task.key, widget.task);
//          });
//        },
//      ),
//      trailing: IconButton(
//        tooltip: DELETE,
//        icon: Icon(AntIcons.delete),
//        onPressed: () => setState(() {
//          Provider.of<TaskViewModel>(context, listen: false)
//              .deleteTask(widget.task.key);
//        }),
//      ),
//    );
//  }
//}
