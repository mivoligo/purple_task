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
            dueDate: e.dueAt,
            doneTime: e.doneAt,
            isDone: e.isDone,
            position: e.position,
          ),
        )
        .toList();
  }

  @override
  Future<void> remove({required int taskId}) => taskDao.deleteTask(taskId);

  @override
  Future<void> removeAllTasksForCategory(int categoryId) =>
      taskDao.deleteAllTasksInCategory(categoryId);

  @override
  Future<void> removeCompletedTasksForCategory(int categoryId) =>
      taskDao.deleteCompletedTasksInCategory(categoryId);

  @override
  Future<void> reorder({required List<Task> affectedTasksList}) async {
    final companionsList = affectedTasksList
        .map(
          (e) => TaskItemsCompanion(
            id: Value(e.id!),
            name: Value(e.name),
            isDone: Value(e.isDone),
            categoryId: Value(e.categoryId),
            position: Value(e.position),
          ),
        )
        .toList();

    await taskDao.updateTasksList(companionsList);
  }

  @override
  Future<void> update({required Task task}) async {
    await taskDao.updateTask(
      TaskItemsCompanion(
        id: Value(task.id!),
        name: Value(task.name),
        description: Value(task.description),
        isDone: Value(task.isDone),
        categoryId: Value(task.categoryId),
        createdAt: Value(task.createTime),
        dueAt: Value(task.dueDate),
        doneAt: Value(task.doneTime),
        position: Value(task.position),
      ),
    );
  }
}
