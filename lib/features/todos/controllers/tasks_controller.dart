import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/repositories/task_repository.dart';
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

  Future<void> remove({required Task task}) async {
    await ref.read(taskRepositoryProvider).remove(task: task);
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

  void reorder({
    required List<String> affectedTasksKeyList,
    required bool indexIncrease,
  }) {
    ref.read(taskRepositoryProvider).reorder(
          affectedTasksKeyList: affectedTasksKeyList,
          indexIncrease: indexIncrease,
        );
    // state = ref.read(taskRepositoryProvider).getTasks();
  }
}
