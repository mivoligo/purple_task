import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/daos/providers/providers.dart';
import 'package:purple_task/features/todos/repositories/base_category_repository.dart';
import 'package:purple_task/features/todos/repositories/base_task_repository.dart';
import 'package:purple_task/features/todos/repositories/drift_category_repository.dart';
import 'package:purple_task/features/todos/repositories/drift_task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
BaseCategoryRepository categoryRepository(Ref ref) {
  final dao = ref.watch(categoryDaoProvider);
  return DriftCategoryRepository(categoryDao: dao);
}

@riverpod
BaseTaskRepository taskRepository(Ref ref) {
  final taskDao = ref.watch(taskDaoProvider);
  return DriftTaskRepository(taskDao: taskDao);
}
