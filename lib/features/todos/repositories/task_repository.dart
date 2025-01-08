import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';
import 'package:purple_task/features/todos/models/task.dart';
import 'package:purple_task/features/todos/models/task_entity.dart';
import 'package:purple_task/features/todos/repositories/base_task_repository.dart';
import 'package:purple_task/features/todos/repositories/drift_task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_repository.g.dart';

class TaskRepository extends BaseTaskRepository {
  final _taskBox = Hive.box<TaskEntity>(taskBox);
  // final _tasksOrderBox = Hive.box<Map<dynamic, dynamic>>(tasksListOrderBox);

  @override
  Future<int> add({required Task task}) async {
    final autoincrementKey = await _taskBox.add(task.toEntity());
    return autoincrementKey;
    // final taskOrder = _tasksOrderBox.get(tasksListOrderKey);
    // taskOrder?[autoincrementKey.toString()] = autoincrementKey;
    // return task;
  }

  @override
  Future<void> update({required Task task}) async {
    await _taskBox.put(task.id, task.toEntity());
  }

  @override
  Future<void> remove({required int taskId}) async {
    await _taskBox.values
        .firstWhere((element) => element.key == taskId)
        .delete();
    // _tasksOrderBox.get(tasksListOrderKey)?.remove(task.id.toString());
  }

  @override
  Future<List<Task>> getTasks() async {
    // final tasksOrder = _tasksOrderBox.get(tasksListOrderKey);

    // if (tasksOrder == null || tasksOrder.isEmpty) {
    //   _tasksOrderBox.put(
    //     tasksListOrderKey,
    //     Map.fromIterable(
    //       _taskBox.values.indexed,
    //       key: (element) => element.$2.key.toString(),
    //       value: (element) => element.$1,
    //     ),
    //   );
    //   ;
    // }

    final values = _taskBox.values.map(Task.fromEntity).toList();
    // ..sort(
    //   (a, b) {
    //     final order = _tasksOrderBox.get(tasksListOrderKey);
    //
    //     if (order == null ||
    //         !order.containsKey(a.id.toString()) ||
    //         !order.containsKey(b.id.toString())) {
    //       return a.name.compareTo(b.name);
    //     }
    //
    //     return order[a.id.toString()]!.compareTo(
    //       order[b.id.toString()]!,
    //     );
    //   },
    // );
    return values;
  }

  @override
  Future<void> removeAllTasksForCategory(int categoryId) async {
    final matches =
        _taskBox.values.where((task) => task.categoryId == categoryId);
    for (final task in matches) {
      // _tasksOrderBox.get(tasksListOrderKey)?.remove(task.key.toString());
      await task.delete();
    }
  }

  @override
  Future<void> removeCompletedTasksForCategory(int categoryId) async {
    final matches = _taskBox.values
        .where((task) => task.categoryId == categoryId && task.isDone == true);
    for (final task in matches) {
      // _tasksOrderBox.get(tasksListOrderKey)?.remove(task.key.toString());
      await task.delete();
    }
  }

  @override
  Future<void> reorder({required List<Task> affectedTasksList}) async {
    // final tasksOrder = _tasksOrderBox.get(tasksListOrderKey, defaultValue: {});

    // if (tasksOrder == null) {
    //   return;
    // }
    //
    // final originalOrder = Map.unmodifiable(tasksOrder);
    //
    // if (indexIncrease) {
    //   for (var i = 0; i < affectedTasksKeyList.length; i++) {
    //     if (i == 0) {
    //       tasksOrder.update(
    //         affectedTasksKeyList[i],
    //         (value) => originalOrder[affectedTasksKeyList.last],
    //       );
    //     } else {
    //       tasksOrder.update(
    //         affectedTasksKeyList[i],
    //         (value) => originalOrder[affectedTasksKeyList[i - 1]],
    //       );
    //     }
    //   }
    // } else {
    //   for (var i = 0; i < affectedTasksKeyList.length; i++) {
    //     if (i == affectedTasksKeyList.length - 1) {
    //       tasksOrder.update(
    //         affectedTasksKeyList[i],
    //         (value) => originalOrder[affectedTasksKeyList.first],
    //       );
    //     } else {
    //       tasksOrder.update(
    //         affectedTasksKeyList[i],
    //         (value) => originalOrder[affectedTasksKeyList[i + 1]],
    //       );
    //     }
    //   }
    // }
    //
    // _tasksOrderBox.put(tasksListOrderKey, tasksOrder);
  }
}

@riverpod
BaseTaskRepository taskRepository(Ref ref) {
  final taskDao = ref.watch(taskDaoProvider);
  return DriftTaskRepository(taskDao: taskDao);
}
