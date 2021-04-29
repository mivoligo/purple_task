import 'package:hive/hive.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 0)
class CategoryEntity extends HiveObject {
  CategoryEntity({
    required this.name,
    required this.color,
    required this.icon,
    required this.id,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int color;

  @HiveField(2)
  final int icon;

  @HiveField(3)
  final int id;
}
