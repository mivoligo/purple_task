import 'package:ant_icons/ant_icons.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

enum NewCategoryStatus { initial, name, color, icon, tasks }

class NewCategoryState extends Equatable {
  NewCategoryState({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.tasks,
    required this.status,
  });

  factory NewCategoryState.initial() {
    return NewCategoryState(
      id: DateTime.now().millisecondsSinceEpoch,
      name: '',
      color: Colors.purple,
      icon: AntIcons.folder.codePoint,
      tasks: [],
      status: NewCategoryStatus.initial,
    );
  }

  final int id;
  final String name;
  final Color color;
  final int icon;
  final List<Task> tasks;
  final NewCategoryStatus status;

  NewCategoryState copyWith({
    int? id,
    String? name,
    Color? color,
    int? icon,
    List<Task>? tasks,
    NewCategoryStatus? status,
  }) {
    return NewCategoryState(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name, color, icon, tasks, status];
}
