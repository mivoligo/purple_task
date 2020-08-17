import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

class AddTaskField extends StatefulWidget {
  final Function addTask;

  const AddTaskField({
    Key key,
    @required this.addTask,
  }) : super(key: key);

  @override
  _AddTaskFieldState createState() => _AddTaskFieldState();
}

class _AddTaskFieldState extends State<AddTaskField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getTaskName(BuildContext context) {
    if (_controller.text.isNotEmpty)
      Provider.of<TaskViewModel>(context, listen: false).newTaskName =
          _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: _controller.text.isEmpty
          ? null
          : (v) {
              getTaskName(context);
              widget.addTask();
              _controller.clear();
            },
      decoration: InputDecoration(
        suffix: IconButton(
          color: _controller.text.isEmpty ? Colors.grey : Colors.blue,
          icon: Icon(
            AntIcons.plus_circle,
          ),
          onPressed: _controller.text.isEmpty
              ? null
              : () {
                  getTaskName(context);
                  widget.addTask();
                  _controller.clear();
                },
        ),
      ),
    );
  }
}
