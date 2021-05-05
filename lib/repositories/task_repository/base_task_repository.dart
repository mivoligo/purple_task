import '../../models/models.dart';

abstract class BaseTaskRepository {
  Future<Task> add({required Task task});

  Future<Task> update({required Task task});

  Future<Task> remove({required Task task});

  List<Task> getTasks();

  Future<void> removeAllTasksForCategory(int categoryId);

  Future<void> removeCompletedTasksForCategory(int categoryId);
}
