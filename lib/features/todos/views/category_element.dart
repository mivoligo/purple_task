import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/constants/strings/strings.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/category_element_base.dart';

class CategoryElement extends ConsumerWidget {
  const CategoryElement(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTasksNumber =
        ref.watch(numberOfActiveTasksInCategoryProvider(category.id));
    final completionProgress =
        ref.watch(completionProgressProvider(category.id));

    final progressString = switch (activeTasksNumber) {
      1 => '$activeTasksNumber $taskSingular',
      _ => '$activeTasksNumber $taskPlural',
    };

    return CategoryElementBase(
      icon: category.icon,
      name: category.name,
      description: progressString,
      progress: completionProgress,
      color: category.color,
    );
  }
}
