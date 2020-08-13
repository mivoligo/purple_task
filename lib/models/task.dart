import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isDone;

  @HiveField(2)
  final int categoryId;

  Task({
    @required this.name,
    @required this.isDone,
    @required this.categoryId,
  });
}
