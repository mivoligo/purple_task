import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum EditCategoryStatus { initial, data, error }

class EditCategoryState extends Equatable {
  EditCategoryState({
    required this.color,
    required this.icon,
    required this.status,
  });

  factory EditCategoryState.initial() {
    return EditCategoryState(
      color: Colors.black,
      icon: 1,
      status: EditCategoryStatus.initial,
    );
  }

  final Color color;
  final int icon;
  final EditCategoryStatus status;

  EditCategoryState copyWith({
    Color? color,
    int? icon,
    EditCategoryStatus? status,
  }) {
    return EditCategoryState(
      color: color ?? this.color,
      icon: icon ?? this.icon,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [color, icon, status];
}
