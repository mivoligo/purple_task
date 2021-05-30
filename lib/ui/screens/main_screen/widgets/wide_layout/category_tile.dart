import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../../widgets/widgets.dart';

class CategoryTile extends ConsumerWidget {
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final progress = watch(progressProvider(category.id));
    final isCurrentCategory =
        watch(currentCategoryProvider).state?.id == category.id;
    var description = '';
    final activeTasksNumber = watch(
      activeTasksNumberProvider(category.id),
    );
    switch (activeTasksNumber) {
      case 0:
        description = '$activeTasksNumber ${s.taskPlural}';
        break;
      case 1:
        description = '$activeTasksNumber ${s.taskSingular}';
        break;
      default:
        description = '$activeTasksNumber ${s.taskPlural}';
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.decelerate,
      margin: EdgeInsets.only(
        left: isCurrentCategory ? 12 : 24,
        top: 4,
        right: isCurrentCategory ? 12 : 24,
        bottom: 8,
      ),
      decoration: CustomStyle.categoryCardDecoration,
      child: InkWell(
        onTap: () {
          isCurrentCategory
              ? watch(currentCategoryProvider).state = null
              : watch(currentCategoryProvider).state = category;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      IconData(
                        category.icon,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      size: 38.0,
                      color: category.color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${category.name}',
                      style: CustomStyle.textStyle20,
                    ),
                  ),
                  if (isCurrentCategory)
                    CategoryMenu(
                      categoryId: category.id,
                      onRemoveAllTasks: () => _removeAllTasks(context),
                      onRemoveCategory: () => _removeCategoryAndTasks(context),
                      onRemoveCompletedTasks: () =>
                          _removeCompletedTasks(context),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 12, right: 8),
                child: Text(description),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedProgressBar(
                        value: progress,
                        color: category.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${(progress * 100).toInt()}%'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeAllTasks(BuildContext context) {
    context
        .read(tasksProvider.notifier)
        .removeAllTasksForCategory(categoryId: category.id);
  }

  void _removeCompletedTasks(BuildContext context) {
    context
        .read(tasksProvider.notifier)
        .removeCompletedTasksForCategory(categoryId: category.id);
  }

  void _removeCategoryAndTasks(BuildContext context) {
    // delete tasks with category id
    _removeAllTasks(context);
    // delete category
    context.read(categoriesProvider.notifier).remove(category: category);
    // remove category from current category state
    context.read(currentCategoryProvider).state = null;
  }
}
