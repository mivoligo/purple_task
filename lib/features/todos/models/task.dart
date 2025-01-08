import 'package:equatable/equatable.dart';

import 'package:purple_task/features/todos/models/task_entity.dart';

class Task extends Equatable {
  const Task({
    required this.name,
    required this.categoryId,
    this.isDone = false,
    this.description,
    this.createTime,
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
  final String? description;
  final bool isDone;
  final int categoryId;
  final int? createTime;
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
    String? Function()? description,
    bool? isDone,
    int? categoryId,
    int? Function()? dueDate,
    int? Function()? doneTime,
    int? position,
  }) {
    return Task(
      id: id,
      name: name ?? this.name,
      description: description != null ? description() : this.description,
      isDone: isDone ?? this.isDone,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      doneTime: doneTime != null ? doneTime() : this.doneTime,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        isDone,
        categoryId,
        createTime,
        dueDate,
        doneTime,
        id,
        position,
      ];
}
