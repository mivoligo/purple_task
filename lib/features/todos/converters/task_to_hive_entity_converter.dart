import 'package:purple_task/features/todos/models/hive_entities/task_entity.dart';
import 'package:purple_task/features/todos/models/task.dart';

mixin TaskToHiveEntityConverter {
  Task entityToTask(TaskEntity entity) {
    return Task(
      name: entity.name,
      isDone: entity.isDone,
      categoryId: entity.categoryId,
      dueDate: entity.dueDate,
      doneTime: entity.doneTime,
      id: int.tryParse(entity.key.toString()),
    );
  }

  TaskEntity taskToEntity(Task task) {
    return TaskEntity(
      name: task.name,
      isDone: task.isDone,
      categoryId: task.categoryId,
      doneTime: task.doneTime,
      dueDate: task.dueDate,
    );
  }
}
