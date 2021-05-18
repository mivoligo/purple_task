import 'package:hive/hive.dart';
import '../../constants/constants.dart';
import '../../entities/entities.dart';
import '../../models/models.dart';
import '../repositories.dart';

class TaskRepository extends BaseTaskRepository {
  final _box = Hive.box<TaskEntity>(taskBox);

  @override
  Future<Task> add({required Task task}) async {
    final key = await _box.add(task.toEntity());
    task = task.copyWith(key: key);
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

  @override
  Future<void> removeAllTasksForCategory(int categoryId) async {
    final matches = _box.values.where((task) => task.categoryId == categoryId);
    for (var task in matches) {
      await task.delete();
    }
  }

  @override
  Future<void> removeCompletedTasksForCategory(int categoryId) async {
    final matches = _box.values
        .where((task) => task.categoryId == categoryId && task.isDone == true);
    for (var task in matches) {
      await task.delete();
    }
  }
}
