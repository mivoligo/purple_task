import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/category_element_base.dart';
import 'package:purple_task/l10n/app_localizations.dart';

class CategoryElement extends ConsumerWidget {
  const CategoryElement(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context);
    final activeTasksNumber =
        ref.watch(numberOfActiveTasksInCategoryProvider(category.id));
    final completionProgress =
        ref.watch(completionProgressProvider(category.id));

    return CategoryElementBase(
      icon: category.icon,
      name: category.name,
      description: tr.categoryTasksInfo(activeTasksNumber),
      progress: completionProgress,
      color: category.color,
    );
  }
}
