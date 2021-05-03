import '../../models/models.dart';

abstract class BaseTaskRepository {
  Future<Task> addTask(Task task);

  Future<Task> updateTask(Task task);

  Future<Task> deleteTask(Task task);

  List<Task> getTasks();
}
