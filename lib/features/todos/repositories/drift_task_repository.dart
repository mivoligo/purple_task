import 'package:drift/drift.dart';
import 'package:purple_task/core/database/app_database.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/repositories/base_task_repository.dart';

class DriftTaskRepository implements BaseTaskRepository {
  DriftTaskRepository({required this.taskDao});

  final TaskDao taskDao;

  @override
  Future<int> add({required Task task}) async => taskDao.addTask(
        TaskItemsCompanion(
          name: Value(task.name),
          categoryId: Value(task.categoryId),
          description: Value(task.description),
          createdAt: Value(task.createTime),
          dueAt: Value(task.dueDate),
        ),
      );

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await taskDao.getAllTasks();

    return tasks
        .map(
          (e) => Task(
            id: e.id,
            name: e.name,
            categoryId: e.categoryId,
            description: e.description,
            createTime: e.createdAt,
            dueDate: e.doneAt,
            doneTime: e.doneAt,
            isDone: e.isDone,
            position: e.position,
          ),
        )
        .toList();
  }

  @override
  Future<Task> remove({required Task task}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllTasksForCategory(int categoryId) {
    // TODO: implement removeAllTasksForCategory
    throw UnimplementedError();
  }

  @override
  Future<void> removeCompletedTasksForCategory(int categoryId) {
    // TODO: implement removeCompletedTasksForCategory
    throw UnimplementedError();
  }

  @override
  void reorder(
      {required List<String> affectedTasksKeyList,
      required bool indexIncrease}) {
    // TODO: implement reorder
  }

  @override
  Future<Task> update({required Task task}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
