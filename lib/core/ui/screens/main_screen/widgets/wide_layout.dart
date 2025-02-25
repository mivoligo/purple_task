import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/top_bar.dart';
import 'package:purple_task/features/todos/controllers/category_controller.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/views/add_category_button.dart';
import 'package:purple_task/features/todos/views/category_details.dart';
import 'package:purple_task/features/todos/views/category_element.dart';
import 'package:purple_task/features/todos/views/category_list.dart';
import 'package:purple_task/features/todos/views/uncategorized_menu.dart';
import 'package:purple_task/features/todos/views/uncategorized_tasks.dart';

class WideLayout extends ConsumerWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategory = ref.watch(categoryNotifierProvider);
    final theme = Theme.of(context);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: TopBar(),
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 360,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: _UncategorizedCard(
                        isSelected: currentCategory == null,
                      ),
                    ),
                    const Divider(
                      height: 16,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const Expanded(
                      child: CategoryList(shouldPushDetails: false),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Center(child: AddCategoryButton()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8, bottom: 16, right: 16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: DecoratedBox(
                        decoration:
                            CustomStyle.uncategorizedTasksDecoration.copyWith(
                          color:
                              theme.colorScheme.surfaceContainer.withAlpha(180),
                        ),
                        child: currentCategory != null
                            ? CategoryDetails(category: currentCategory)
                            : const UncategorizedTasks(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UncategorizedCard extends ConsumerWidget {
  const _UncategorizedCard({
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncategorizedCategory = Category(
      id: -1,
      name: noCategory,
      icon: AntIcons.appstore.codePoint,
      color: Colors.deepPurple,
    );
    return InkWell(
      onTap: () =>
          ref.read(categoryNotifierProvider.notifier).setCurrentCategory(null),
      child: Transform.scale(
        scale: isSelected ? 1.03 : 1,
        child: Card(
          margin: EdgeInsets.zero,
          shape: isSelected
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                    color: Colors.deepPurple,
                    width: 4,
                    strokeAlign: -4,
                  ),
                )
              : null,
          child: Padding(
            padding: isSelected
                ? const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  )
                : const EdgeInsets.all(8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: CategoryElement(
                      uncategorizedCategory,
                    ),
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalDivider(),
                      UncategorizedMenu(iconSize: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
