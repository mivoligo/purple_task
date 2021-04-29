import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Task extends Equatable {
  Task({
    required this.name,
    this.isDone = false,
    required this.categoryId,
    this.dueDate,
    this.doneTime,
    this.key,
  });

  factory Task.fromEntity(TaskEntity entity) {
    return Task(
      name: entity.name,
      isDone: entity.isDone,
      categoryId: entity.categoryId,
      dueDate: entity.dueDate,
      doneTime: entity.doneTime,
      key: entity.key,
    );
  }

  final String name;
  final bool isDone;
  final int categoryId;
  final int? dueDate;
  final int? doneTime;
  final dynamic key;

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
    int? dueDate,
    int? doneTime,
    dynamic key,
  }) {
    return Task(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate ?? this.dueDate,
      doneTime: doneTime ?? this.doneTime,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [name, isDone, categoryId, dueDate, doneTime, key];
}
