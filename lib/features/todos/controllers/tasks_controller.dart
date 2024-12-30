import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/repositories/task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_controller.g.dart';

@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  List<Task> build() {
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> add({required Task task}) async {
    await ref.read(taskRepositoryProvider).add(task: task);
    state = ref.read(taskRepositoryProvider).getTasks();
  }

  Future<void> remove({required Task task}) async {
    await ref.read(taskRepositoryProvider).remove(task: task);
    state = ref.read(taskRepositoryProvider).getTasks();
  }

  Future<void> update({required Task task}) async {
    await ref.read(taskRepositoryProvider).update(task: task);
    state = ref.read(taskRepositoryProvider).getTasks();
  }

  Future<void> removeAllTasksForCategory({required int categoryId}) async {
    await ref
        .read(taskRepositoryProvider)
        .removeAllTasksForCategory(categoryId);
    state = ref.read(taskRepositoryProvider).getTasks();
  }

  Future<void> removeCompletedTasksForCategory({
    required int categoryId,
  }) async {
    await ref
        .read(taskRepositoryProvider)
        .removeCompletedTasksForCategory(categoryId);
    state = ref.read(taskRepositoryProvider).getTasks();
  }

  void reorder({
    required List<String> affectedTasksKeyList,
    required bool indexIncrease,
  }) {
    ref.read(taskRepositoryProvider).reorder(
          affectedTasksKeyList: affectedTasksKeyList,
          indexIncrease: indexIncrease,
        );
    state = ref.read(taskRepositoryProvider).getTasks();
  }
}
