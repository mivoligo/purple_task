import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    this.position,
  });

  final int id;
  final String name;
  final Color color;
  final int icon;
  final int? position;

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

  @override
  List<Object?> get props => [id, name, color, icon, position];
}
