import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task({
    required this.name,
    required this.isDone,
    required this.categoryId,
    this.dueDate,
    this.doneTime,
  });

  final String name;
  final bool isDone;
  final int categoryId;
  final int? dueDate;
  final int? doneTime;

  Task copyWith({
    String? name,
    bool? isDone,
    int? categoryId,
    int? dueDate,
    int? doneTime,
  }) {
    return Task(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      categoryId: categoryId ?? this.categoryId,
      dueDate: dueDate ?? this.dueDate,
      doneTime: doneTime ?? this.doneTime,
    );
  }

  @override
  List<Object?> get props => [
        name,
        isDone,
        categoryId,
        dueDate,
        doneTime,
      ];

  @override
  bool? get stringify => true;
}
