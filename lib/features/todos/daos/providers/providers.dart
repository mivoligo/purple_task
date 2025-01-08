import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/database/providers/providers.dart';
import 'package:purple_task/features/todos/daos/category_dao.dart';
import 'package:purple_task/features/todos/daos/task_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
TaskDao taskDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return TaskDao(database);
}

@riverpod
CategoryDao categoryDao(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return CategoryDao(database);
}
