import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  int categoryId;

  Task({
    @required this.name,
    @required this.isDone,
    @required this.categoryId,
  });
}
