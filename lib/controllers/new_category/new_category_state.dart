import 'package:ant_icons/ant_icons.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

enum NewCategoryStatus { initial, name, color, icon, tasks }

class NewCategoryState extends Equatable {
  NewCategoryState({
    required this.name,
    required this.color,
    required this.icon,
    required this.tasks,
    required this.status,
  });

  factory NewCategoryState.initial() {
    return NewCategoryState(
      name: '',
      color: Colors.purple,
      icon: AntIcons.folder.codePoint,
      tasks: [],
      status: NewCategoryStatus.initial,
    );
  }

  NewCategoryState copyWith({
    String? name,
    Color? color,
    int? icon,
    List<Task>? tasks,
    NewCategoryStatus? status,
  }) {
    return NewCategoryState(
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }

  final String name;
  final Color color;
  final int icon;
  final List<Task> tasks;
  final NewCategoryStatus status;

  @override
  List<Object?> get props => [name, color, icon, tasks, status];
}
