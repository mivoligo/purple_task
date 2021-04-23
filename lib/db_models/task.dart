import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class TaskEntity extends HiveObject {
  TaskEntity({
    required this.name,
    required this.isDone,
    required this.categoryId,
    this.doneTime,
    this.dueDate,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  int categoryId;

  @HiveField(3)
  int? doneTime;

  @HiveField(4)
  int? dueDate;
}
