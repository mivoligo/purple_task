import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globals.dart';
import '../bloc/new_task_cubit.dart';
import '../data/repositories/task_repository.dart';

class AddTaskInput extends StatelessWidget {
  const AddTaskInput({this.categoryId = -1});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTaskCubit>(
      create: (context) => NewTaskCubit(context.read<TaskRepository>())
        ..loadEmptyTask(categoryId: categoryId),
      child: AddTaskInputChild(),
    );
  }
}

class AddTaskInputChild extends StatefulWidget {
  const AddTaskInputChild();

  @override
  _AddTaskInputChildState createState() => _AddTaskInputChildState();

// final VoidCallback onSubmitted;
}

class _AddTaskInputChildState extends State<AddTaskInputChild> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  // bool hasText = controller.text.isNotEmpty ;

  @override
  void initState() {
    // for real time updates of text entry UI
    // controller.addListener(updateField);
    controller.text = '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // void updateField() {
  //   setState(() {
  //     hasText = controller.text.isNotEmpty;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskCubit, NewTaskState>(builder: (context, state) {
      var hasText = controller.text.trim().isNotEmpty;
      return CupertinoTextField(
        controller: controller,
        focusNode: focusNode,
        placeholder: addNewTask,
        padding: EdgeInsets.only(left: 16.0),
        style: Theme.of(context).textTheme.subtitle1,
        decoration: CustomStyles().inputDecoration,
        suffix: IconButton(
          color: hasText ? Colors.blue : Colors.grey,
          icon: Icon(
            AntIcons.plus_circle,
          ),
          onPressed: hasText
              ? () {
                  addTask(
                    context,
                    isSubmitting: state.status == NewTaskStatus.submitting,
                  );
                  controller.clear();
                  focusNode.requestFocus();
                }
              : null,
        ),
        onChanged: (value) =>
            context.read<NewTaskCubit>().nameChanged(name: value),
        onSubmitted: hasText
            ? (_) {
                addTask(
                  context,
                  isSubmitting: state.status == NewTaskStatus.submitting,
                );
                controller.clear();
                focusNode.requestFocus();
              }
            : null,
      );
    });
  }

  void addTask(BuildContext context, {required bool isSubmitting}) {
    if (!isSubmitting) {
      context.read<NewTaskCubit>().addTask();
    }
  }
}
