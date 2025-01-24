import 'dart:ui';

import 'package:equatable/equatable.dart';

class NewCategory extends Equatable {
  const NewCategory({
    required this.name,
    required this.color,
    required this.icon,
  });

  final String name;
  final Color color;
  final int icon;

  @override
  List<Object?> get props => [name, color, icon];
}
