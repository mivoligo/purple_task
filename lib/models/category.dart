import 'package:hive/hive.dart';
import 'package:to_do/models/task.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int color;

  @HiveField(2)
  final int icon;

  @HiveField(3)
  List<Task> tasks;

  Category({
    this.name,
    this.color,
    this.icon,
    this.tasks,
  });
}
