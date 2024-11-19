import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

part 'tasks_controller.g.dart';

@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  List<Task> build() {
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> add({required Task task}) async {
    final newTask = await ref.read(taskRepositoryProvider).add(task: task);
    state = [...state, newTask];
  }

  Future<void> remove({required Task task}) async {
    await ref.read(taskRepositoryProvider).remove(task: task);
    state = state.where((element) => element.key != task.key).toList();
  }

  Future<void> update({required Task task}) async {
    await ref.read(taskRepositoryProvider).update(task: task);
    state = [
      for (final element in state)
        if (element.key == task.key) task else element,
    ];
  }

  Future<void> removeAllTasksForCategory({required int categoryId}) async {
    await ref
        .read(taskRepositoryProvider)
        .removeAllTasksForCategory(categoryId);
    state = state.where((element) => element.categoryId != categoryId).toList();
  }

  Future<void> removeCompletedTasksForCategory(
      {required int categoryId}) async {
    await ref
        .read(taskRepositoryProvider)
        .removeCompletedTasksForCategory(categoryId);
    state = state
        .where(
            (element) => !(element.categoryId == categoryId && element.isDone))
        .toList();
  }
}
