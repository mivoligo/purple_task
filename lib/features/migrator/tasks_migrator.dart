import 'package:drift/drift.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/database/app_database.dart';
import 'package:purple_task/core/hive_legacy/hive_entities/task_entity.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';

class TasksMigrator {
  const TasksMigrator({
    required Box<TaskEntity> tasksBox,
    required TaskDao taskDao,
  })  : _tasksBox = tasksBox,
        _taskDao = taskDao;

  final Box<TaskEntity> _tasksBox;
  final TaskDao _taskDao;

  Future<void> migrateTasksFromHiveToDrift() async {
    final companions = _tasksBox.values
        .map(
          (e) => TaskItemsCompanion(
            name: Value(e.name),
            isDone: Value(e.isDone),
            categoryId: Value(e.categoryId),
            dueAt: Value(e.dueDate),
            doneAt: Value(e.doneTime),
          ),
        )
        .toList(growable: false);

    await _taskDao.addTasksList(companions);
  }
}
