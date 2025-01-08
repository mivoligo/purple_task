import 'package:equatable/equatable.dart';

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

  final int? id;
  final String name;
  final String? description;
  final bool isDone;
  final int categoryId;
  final int? createTime;
  final int? dueDate;
  final int? doneTime;
  final int? position;

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
