import 'package:hive/hive.dart';
import '../../constants/constants.dart';
import '../../entities/entities.dart';
import '../../models/models.dart';
import 'base_task_repository.dart';

class TaskRepository extends BaseTaskRepository {
  final _taskBox = Hive.box<TaskEntity>(taskBox);
  final _tasksOrderBox = Hive.box<Map<dynamic, dynamic>>(tasksListOrderBox);

  @override
  Future<Task> add({required Task task}) async {
    final key = await _taskBox.add(task.toEntity());
    task = task.copyWith(key: key);
    _tasksOrderBox.get(tasksListOrderKey)?[key.toString()] = key;
    return task;
  }

  @override
  Future<Task> update({required Task task}) async {
    await _taskBox.put(task.key, task.toEntity());
    return task;
  }

  @override
  Future<Task> remove({required Task task}) async {
    await _taskBox.values
        .firstWhere((element) => element.key == task.key)
        .delete();
    _tasksOrderBox.get(tasksListOrderKey)?.remove(task.key.toString());
    return task;
  }

  @override
  List<Task> getTasks() {
    var tasksOrder = _tasksOrderBox.get(tasksListOrderKey);

    if (tasksOrder == null || tasksOrder.isEmpty) {
      _tasksOrderBox.put(
        tasksListOrderKey,
        Map.fromIterable(
          _taskBox.values.indexed,
          key: (element) => element.$2.key.toString(),
          value: (element) => element.$1,
        ),
      );
      ;
    }

    final values = _taskBox.values.map(Task.fromEntity).toList()
      ..sort(
        (a, b) {
          var order = _tasksOrderBox.get(tasksListOrderKey);
          return order![a.key.toString()]!.compareTo(
            order[b.key.toString()]!,
          ); // todo zabezpieczyć przed nullami
        },
      );
    return values;
  }

  @override
  Future<void> removeAllTasksForCategory(int categoryId) async {
    final matches =
        _taskBox.values.where((task) => task.categoryId == categoryId);
    for (var task in matches) {
      _tasksOrderBox.get(tasksListOrderKey)?.remove(task.key.toString());
      await task.delete();
    }
  }

  @override
  Future<void> removeCompletedTasksForCategory(int categoryId) async {
    final matches = _taskBox.values
        .where((task) => task.categoryId == categoryId && task.isDone == true);
    for (var task in matches) {
      _tasksOrderBox.get(tasksListOrderKey)?.remove(task.key.toString());
      await task.delete();
    }
  }

  @override
  void reorder({
    required List<String> affectedTasksKeyList,
    required bool indexIncrease,
  }) {
    final tasksOrder = _tasksOrderBox.get(tasksListOrderKey, defaultValue: {});

    if (tasksOrder == null) {
      return;
    }

    final originalOrder = Map.unmodifiable(tasksOrder);

    if (indexIncrease) {
      for (var i = 0; i < affectedTasksKeyList.length; i++) {
        if (i == 0) {
          tasksOrder.update(
            affectedTasksKeyList[i],
            (value) => originalOrder[affectedTasksKeyList.last],
          );
        } else {
          tasksOrder.update(
            affectedTasksKeyList[i],
            (value) => originalOrder[affectedTasksKeyList[i - 1]],
          );
        }
      }
    } else {
      for (var i = 0; i < affectedTasksKeyList.length; i++) {
        if (i == affectedTasksKeyList.length - 1) {
          tasksOrder.update(
            affectedTasksKeyList[i],
            (value) => originalOrder[affectedTasksKeyList.first],
          );
        } else {
          tasksOrder.update(
            affectedTasksKeyList[i],
            (value) => originalOrder[affectedTasksKeyList[i + 1]],
          );
        }
      }
    }

    _tasksOrderBox.put(tasksListOrderKey, tasksOrder);
  }
}
