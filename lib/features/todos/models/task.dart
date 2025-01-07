import 'package:equatable/equatable.dart';

import 'package:purple_task/features/todos/models/task_entity.dart';

class Task extends Equatable {
  const Task({
    required this.name,
    required this.categoryId,
    this.isDone = false,
    this.dueDate,
    this.doneTime,
    this.id,
    this.position,
  });

  Task.fromEntity(TaskEntity entity)
      : this(
          name: entity.name,
          isDone: entity.isDone,
          categoryId: entity.categoryId,
          dueDate: entity.dueDate,
          doneTime: entity.doneTime,
          id: int.tryParse(entity.key.toString()),
        );

  final int? id;
  final String name;
  final bool isDone;
  final int categoryId;
  final int? dueDate;
  final int? doneTime;
  final int? position;

  TaskEntity toEntity() {
    return TaskEntity(
      name: name,
      isDone: isDone,
      categoryId: categoryId,
      dueDate: dueDate,
      doneTime: doneTime,
    );
  }

  Task copyWith({
    String? name,
    bool? isDone,
    int? categoryId,
    int? Function()? dueDate,
    int? doneTime,
    int? id,
    int? position,
  }) {
    return Task(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      doneTime: doneTime ?? this.doneTime,
      id: id ?? this.id,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [
        name,
        isDone,
        categoryId,
        dueDate,
        doneTime,
        id,
        position,
      ];
}
