import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globals.dart';
import '../bloc/new_task_cubit.dart';
import '../bloc/task_list_cubit.dart';
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
}

class _AddTaskInputChildState extends State<AddTaskInputChild> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    controller.text = '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTaskCubit, NewTaskState>(
      listener: (context, state) {
        if (state.status == NewTaskStatus.success) {
          context.read<TaskListCubit>().loadTasksForCategory(state.categoryId);
        }
      },
      builder: (context, state) {
        var hasText = controller.text.trim().isNotEmpty;
        return CupertinoTextField(
          controller: controller,
          focusNode: focusNode,
          placeholder: addNewTask,
          padding: EdgeInsets.only(left: 16.0),
          style: Theme.of(context).textTheme.subtitle1,
          decoration: CustomStyles.inputDecoration,
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
      },
    );
  }

  void addTask(BuildContext context, {required bool isSubmitting}) {
    if (!isSubmitting) {
      context.read<NewTaskCubit>().addTask();
    }
  }
}
