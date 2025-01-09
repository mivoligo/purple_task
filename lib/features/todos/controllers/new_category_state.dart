import 'package:ant_icons/ant_icons.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum NewCategoryStatus { initial, name, color, icon, tasks }

class NewCategoryState extends Equatable {
  const NewCategoryState({
    required this.name,
    required this.color,
    required this.icon,
    required this.tasksNamesList,
    required this.status,
  });

  factory NewCategoryState.initial() {
    return NewCategoryState(
      name: '',
      color: Colors.purple,
      icon: AntIcons.folder.codePoint,
      tasksNamesList: const [],
      status: NewCategoryStatus.initial,
    );
  }

  final String name;
  final Color color;
  final int icon;
  final List<String> tasksNamesList;
  final NewCategoryStatus status;

  NewCategoryState copyWith({
    String? name,
    Color? color,
    int? icon,
    List<String>? tasksNamesList,
    NewCategoryStatus? status,
  }) {
    return NewCategoryState(
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      tasksNamesList: tasksNamesList ?? this.tasksNamesList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [name, color, icon, tasksNamesList, status];
}
