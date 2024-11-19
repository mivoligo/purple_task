import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../controllers/controllers.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(completionProgressProvider(category.id));
    final isCurrentCategory =
        ref.watch(currentCategoryProvider)?.id == category.id;
    var description = '';
    final activeTasksNumber = ref.watch(
      numberOfActiveTasksInCategoryProvider(category.id),
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
              ? ref
                  .read(currentCategoryProvider.notifier)
                  .setCurrentCategory(null)
              : ref
                  .watch(currentCategoryProvider.notifier)
                  .setCurrentCategory(category);
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
                      onRemoveAllTasks: () => _removeAllTasks(ref),
                      onRemoveCategory: () => _removeCategoryAndTasks(ref),
                      onRemoveCompletedTasks: () => _removeCompletedTasks(ref),
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

  void _removeAllTasks(WidgetRef ref) {
    ref
        .read(tasksNotifierProvider.notifier)
        .removeAllTasksForCategory(categoryId: category.id);
  }

  void _removeCompletedTasks(WidgetRef ref) {
    ref
        .read(tasksNotifierProvider.notifier)
        .removeCompletedTasksForCategory(categoryId: category.id);
  }

  void _removeCategoryAndTasks(WidgetRef ref) {
    // delete tasks with category id
    _removeAllTasks(ref);
    // delete category
    ref.read(categoriesNotifierProvider.notifier).remove(category: category);
    // remove category from current category state
    ref.read(currentCategoryProvider.notifier).setCurrentCategory(null);
  }
}
