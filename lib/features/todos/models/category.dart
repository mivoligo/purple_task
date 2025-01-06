import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    this.position,
  });

  factory Category.fromEntity(CategoryEntity entity) {
    return Category(
      id: entity.id,
      name: entity.name,
      color: Color(entity.color),
      icon: entity.icon,
    );
  }

  const Category.empty()
      : this(id: 0, name: '', color: Colors.deepPurple, icon: 0);

  final int id;
  final String name;
  final Color color;
  final int icon;
  final int? position;

  @override
  List<Object?> get props => [id, name, color, icon];

  CategoryEntity toEntity() {
    return CategoryEntity(
      name: name,
      color: color.intValue,
      icon: icon,
      id: id,
    );
  }

  Category copyWith({
    int? id,
    String? name,
    Color? color,
    int? icon,
    int? position,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      position: position ?? this.position,
    );
  }
}
