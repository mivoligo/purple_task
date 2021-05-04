import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../globals/globals.dart' as g;
import '../../entities/entities.dart';
import '../../models/models.dart';
import '../repositories.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

class TaskRepository extends BaseTaskRepository {
  final _box = Hive.box<TaskEntity>(g.taskBox);

  @override
  Future<Task> add({required Task task}) async {
    await _box.add(task.toEntity());
    return task;
  }

  @override
  Future<Task> update({required Task task}) async {
    await _box.put(task.key, task.toEntity());
    return task;
  }

  @override
  Future<Task> remove({required Task task}) async {
    await _box.values.firstWhere((element) => element.key == task.key).delete();
    return task;
  }

  @override
  List<Task> getTasks() {
    return _box.values.map((e) => Task.fromEntity(e)).toList();
  }

  Future<void> deleteAllTasksForCategory(int categoryId) async {
    final matches = _box.values.where((task) => task.categoryId == categoryId);
    for (var task in matches) {
      await task.delete();
    }
  }

  Future<void> deleteCompletedTasksForCategory(int categoryId) async {
    final matches = _box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true);
    for (var task in matches) {
      await task.delete();
    }
  }
}
