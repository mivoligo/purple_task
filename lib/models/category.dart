import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int color;

  @HiveField(2)
  final int icon;

  Category({
    this.name,
    this.color,
    this.icon,
  });
}
