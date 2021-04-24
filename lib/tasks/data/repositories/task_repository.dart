import 'package:hive/hive.dart';

import '../../../db_models/db_models.dart';
import '../../../globals/globals.dart';
import '../models/task.dart';

class TaskRepository {
  Box<TaskEntity> box = Hive.box<TaskEntity>(taskBox);

  Future<Task> addTask(Task task) async {
    await box.add(task.toEntity());
    return task;
  }

  Future<Task> updateTask(Task task) async {
    await box.put(task.key, task.toEntity());
    return task;
  }

  Future<Task> deleteTask(Task task) async {
    await box.values.firstWhere((element) => element.key == task.key).delete();
    return task;
  }

  List<Task> getAllTasksForCategory(int categoryId) {
    final matches = box.values.where((task) => task.categoryId == categoryId);

    return matches.map((e) => Task.fromEntity(e)).toList();
  }
}
