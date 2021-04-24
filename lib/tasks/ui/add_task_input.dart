import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../globals/globals.dart';

class AddTaskInput extends StatefulWidget {
  const AddTaskInput({required this.onSubmitted});

  @override
  _AddTaskInputState createState() => _AddTaskInputState();

  final VoidCallback onSubmitted;
}

class _AddTaskInputState extends State<AddTaskInput> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool hasText = false;

  @override
  void initState() {
    // for real time updates of text entry UI
    controller.addListener(updateField);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void updateField() {
    setState(() {
      hasText = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      placeholder: addNewTask,
      padding: EdgeInsets.only(left: 16.0),
      style: Theme.of(context).textTheme.subtitle1,
      suffix: IconButton(
        color: hasText ? Colors.blue : Colors.grey,
        icon: Icon(
          AntIcons.plus_circle,
        ),
        onPressed: hasText
            ? () {
                widget.onSubmitted;
                controller.clear();
                focusNode.requestFocus();
              }
            : null,
      ),
      onSubmitted: hasText
          ? (_) {
              widget.onSubmitted;
              controller.clear();
              focusNode.requestFocus();
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
