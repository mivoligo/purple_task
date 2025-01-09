import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/repositories/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_controller.g.dart';

@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  Future<List<Task>> build() async =>
      ref.watch(taskRepositoryProvider).getTasks();

  Future<void> add({required Task task}) async {
    await ref.read(taskRepositoryProvider).add(task: task);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> addTasksList({required List<Task> tasksList}) async {
    await ref.read(taskRepositoryProvider).addTasksList(tasksList: tasksList);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> remove({required int taskId}) async {
    await ref.read(taskRepositoryProvider).remove(taskId: taskId);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> updateTask({required Task task}) async {
    await ref.read(taskRepositoryProvider).update(task: task);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> removeAllTasksForCategory({required int categoryId}) async {
    await ref
        .read(taskRepositoryProvider)
        .removeAllTasksForCategory(categoryId);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> removeCompletedTasksForCategory({
    required int categoryId,
  }) async {
    await ref
        .read(taskRepositoryProvider)
        .removeCompletedTasksForCategory(categoryId);
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
  }

  Future<void> reorder({
    required List<Task> affectedTasksList,
    required bool indexIncrease,
  }) async {
    final tasksToBeUpdated = <Task>[];

    if (indexIncrease) {
      for (var i = 0; i < affectedTasksList.length; i++) {
        final currentTask = affectedTasksList[i];
        if (i == 0) {
          tasksToBeUpdated.add(
            currentTask.copyWith(
              position: affectedTasksList.last.position,
            ),
          );
        } else {
          tasksToBeUpdated.add(
            currentTask.copyWith(
              position: affectedTasksList[i - 1].position,
            ),
          );
        }
      }
    } else {
      for (var i = 0; i < affectedTasksList.length; i++) {
        final currentTask = affectedTasksList[i];
        if (i == affectedTasksList.length - 1) {
          tasksToBeUpdated.add(
            currentTask.copyWith(position: affectedTasksList.first.position),
          );
        } else {
          tasksToBeUpdated.add(
            currentTask.copyWith(
              position: affectedTasksList[i + 1].position,
            ),
          );
        }
      }
    }

    await ref.read(taskRepositoryProvider).reorder(
          affectedTasksList: tasksToBeUpdated,
        );
    final updatedTasks = await ref.read(taskRepositoryProvider).getTasks();

    await update((currentState) => [...updatedTasks]);
    // state = ref.read(taskRepositoryProvider).getTasks();
  }
}
