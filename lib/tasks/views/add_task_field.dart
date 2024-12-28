import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/custom_styles.dart';
import '../../constants/strings/strings.dart' as s;

class AddTaskField extends StatefulWidget {
  const AddTaskField({
    Key? key,
    required this.onAddTask,
  }) : super(key: key);

  final Function(String) onAddTask;

  @override
  _AddTaskFieldState createState() => _AddTaskFieldState();
}

class _AddTaskFieldState extends State<AddTaskField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // for real time updates of text entry UI
    _controller.addListener(_updateField);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateField() {
    setState(() {
      _hasText = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      focusNode: _focusNode,
      placeholder: s.addNewTask,
      padding: const EdgeInsets.only(left: 20.0),
      style: CustomStyle.textStyleTaskName,
      suffix: IconButton(
        color: _hasText ? Colors.blue : Colors.grey,
        icon: const Icon(
          AntIcons.plusCircle,
        ),
        onPressed: _hasText
            ? () {
                widget.onAddTask(_controller.text);
                _controller.clear();
                _focusNode.requestFocus();
              }
            : null,
      ),
      onSubmitted: _hasText
          ? (_) {
              widget.onAddTask(_controller.text);
              _controller.clear();
              _focusNode.requestFocus();
            }
          : null,
      decoration: CustomStyle.inputDecoration,
    );
  }
}
