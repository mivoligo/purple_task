import 'package:purple_task/features/todos/models/task.dart';

abstract class BaseTaskRepository {
  Future<Task> add({required Task task});

  Future<Task> update({required Task task});

  Future<Task> remove({required Task task});

  List<Task> getTasks();

  Future<void> removeAllTasksForCategory(int categoryId);

  Future<void> removeCompletedTasksForCategory(int categoryId);

  void reorder({
    required List<String> affectedTasksKeyList,
    required bool indexIncrease,
  });
}
