import 'package:purple_task/features/todos/models/task.dart';

abstract class BaseTaskRepository {
  Future<int> add({required Task task});

  Future<void> update({required Task task});

  Future<void> remove({required int taskId});

  Future<List<Task>> getTasks();

  Future<void> removeAllTasksForCategory(int categoryId);

  Future<void> removeCompletedTasksForCategory(int categoryId);

  Future<void> reorder({required List<Task> affectedTasksList});
}
