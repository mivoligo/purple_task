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
          isDone: Value(task.isDone),
          categoryId: Value(task.categoryId),
          description: Value(task.description),
          createdAt: Value(task.createTime),
          dueAt: Value(task.dueDate),
        ),
      );

  @override
  Future<void> addTasksList({required List<Task> tasksList}) async {
    final companionsList = tasksList
        .map(
          (task) => TaskItemsCompanion(
            name: Value(task.name),
            isDone: Value(task.isDone),
            categoryId: Value(task.categoryId),
            description: Value(task.description),
            createdAt: Value(task.createTime),
            dueAt: Value(task.dueDate),
          ),
        )
        .toList(growable: false);

    await taskDao.addTasksList(companionsList);
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await taskDao.getAllTasks();

    return tasks
        .map(
          (task) => Task(
            id: task.id,
            name: task.name,
            categoryId: task.categoryId,
            description: task.description,
            createTime: task.createdAt,
            dueDate: task.dueAt,
            doneTime: task.doneAt,
            isDone: task.isDone,
            position: task.position,
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
          (task) => TaskItemsCompanion(
            id: Value(task.id!),
            name: Value(task.name),
            isDone: Value(task.isDone),
            categoryId: Value(task.categoryId),
            position: Value(task.position),
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
