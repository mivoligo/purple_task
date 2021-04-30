import 'package:hive/hive.dart';

import '../../../../globals/globals.dart' as g;
import '../../entities/entities.dart';
import '../../models/models.dart';
import '../repositories.dart';

class TaskRepository extends BaseTaskRepository {
  Box<TaskEntity> box = Hive.box<TaskEntity>(g.taskBox);

  @override
  Future<Task> addTask(Task task) async {
    await box.add(task.toEntity());
    return task;
  }

  @override
  Future<Task> updateTask(Task task) async {
    await box.put(task.key, task.toEntity());
    return task;
  }

  @override
  Future<Task> deleteTask(Task task) async {
    await box.values.firstWhere((element) => element.key == task.key).delete();
    return task;
  }

  @override
  List<Task> getAllTasksForCategory(int categoryId) {
    final matches = box.values.where((task) => task.categoryId == categoryId);

    return matches.map((e) => Task.fromEntity(e)).toList();
  }

  Future<void> deleteAllTasksForCategory(int categoryId) async {
    final matches = box.values.where((task) => task.categoryId == categoryId);
    for (var task in matches) {
      await task.delete();
    }
  }

  Future<void> deleteCompletedTasksForCategory(int categoryId) async {
    final matches = box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true);
    for (var task in matches) {
      await task.delete();
    }
  }
}
