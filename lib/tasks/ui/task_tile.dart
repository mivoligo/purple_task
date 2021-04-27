import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';
import '../bloc/task_cubit.dart';
import '../bloc/task_list_cubit.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (context) =>
          TaskCubit(context.read<TaskRepository>())..loadTask(task: task),
      child: TaskTileChild(),
    );
  }
}

class TaskTileChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state.status == TaskStatus.deleted) {
          context
              .read<TaskListCubit>()
              .loadTasksForCategory(state.task!.categoryId);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                    value: state.task!.isDone,
                    onChanged: (value) {
                      context.read<TaskCubit>().setIsDone(isDone: value!);
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    state.task!.name,
                    style: CustomStyles.textStyleTaskName,
                  ),
                ),
                CustomIconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  color: Colors.transparent,
                  onPressed: () {
                    context.read<TaskCubit>().deleteTask();
                  },
                )
              ],
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ],
        );
      },
    );
  }
}
