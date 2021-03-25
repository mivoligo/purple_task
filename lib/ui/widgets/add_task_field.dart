import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class AddTaskField extends StatefulWidget {
  final Function addTask;

  const AddTaskField({
    Key? key,
    required this.addTask,
  }) : super(key: key);

  @override
  _AddTaskFieldState createState() => _AddTaskFieldState();
}

class _AddTaskFieldState extends State<AddTaskField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool _hasText = false;

  @override
  void initState() {
    // for real time updates of text entry UI
    _controller.addListener(_updateField);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _updateField() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  getTaskName(BuildContext context) {
    if (_controller.text.isNotEmpty)
      Provider.of<TaskViewModel>(context, listen: false).newTaskName =
          _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      focusNode: _focusNode,
      placeholder: ADD_NEW_TASK,
      padding: EdgeInsets.only(left: 16.0),
      style: Theme.of(context).textTheme.subtitle1,
      suffix: IconButton(
        color: _hasText ? Colors.blue : Colors.grey,
        icon: Icon(
          AntIcons.plus_circle,
        ),
        onPressed: _hasText
            ? () {
                getTaskName(context);
                widget.addTask();
                _controller.clear();
                _focusNode.requestFocus();
              }
            : null,
      ),
      onSubmitted: _hasText
          ? (v) {
              getTaskName(context);
              widget.addTask();
              _controller.clear();
              _focusNode.requestFocus();
            }
          : null,
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(color: Colors.grey[300]!, offset: Offset(0.0, -2.0)),
            BoxShadow(color: Colors.white, offset: Offset(0.0, 1.0)),
          ]),
    );
  }
}
