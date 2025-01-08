import 'dart:ui';

import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/models/hive_entities/category_entity.dart';

mixin CategoryToHiveEntityConverter {
  Category entityToCategory(CategoryEntity entity) {
    return Category(
      id: entity.id,
      name: entity.name,
      color: Color(entity.color),
      icon: entity.icon,
    );
  }

  CategoryEntity categoryToEntity(Category category) {
    return CategoryEntity(
      name: category.name,
      color: category.color.intValue,
      icon: category.icon,
      id: category.id,
    );
  }
}
