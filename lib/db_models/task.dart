import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  bool? isDone;

  @HiveField(2)
  int? categoryId;

  @HiveField(3)
  int? doneTime;

  @HiveField(4)
  int? dueDate;

  Task({
    required this.name,
    required this.isDone,
    required this.categoryId,
    this.doneTime,
    this.dueDate,
  });
}
