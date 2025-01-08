import 'package:drift/drift.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/database/app_database.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/models/task_entity.dart';

class TasksMigrator {
  TasksMigrator({
    required this.tasksBox,
    required this.taskDao,
  });

  final Box<TaskEntity> tasksBox;
  final TaskDao taskDao;

  Future<void> migrateTasksFromHiveToDrift() async {
    final tasks = tasksBox.values.map(Task.fromEntity).toList();

    for (final task in tasks) {
      await taskDao.addTask(
        TaskItemsCompanion(
          name: Value(task.name),
          isDone: Value(task.isDone),
          categoryId: Value(task.categoryId),
          dueAt: Value(task.dueDate),
          doneAt: Value(task.doneTime),
        ),
      );
    }
  }
}
