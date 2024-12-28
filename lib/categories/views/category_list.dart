import 'dart:ui';

import 'package:ant_icons/ant_icons.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/categories_controller.dart';
import '../controllers/category_controller.dart';
import 'category_element.dart';
import 'category_menu.dart';
import 'category_screen.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({
    required this.shouldPushDetails,
    super.key,
  });

  final bool shouldPushDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesNotifierProvider).valueOrNull ?? [];
    final currentCategoryNotifier =
        ref.watch(categoryNotifierProvider.notifier);
    final currentCategory = ref.watch(categoryNotifierProvider);

    final currentCategoryInList = ref
        .watch(categoriesNotifierProvider)
        .value
        ?.firstWhereOrNull((element) => element.id == currentCategory?.id);

    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final animValue = Curves.easeInOut.transform(animation.value);
          final elevation = lerpDouble(1, 6, animValue);
          final scale = lerpDouble(1, 1.04, animValue);
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: CategoryElement(categories[index])),
                      const VerticalDivider(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          AntIcons.menu,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: categories.length,
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final category = categories[index];
        final needsDecoration =
            !shouldPushDetails && currentCategoryInList == category;
        return Padding(
          key: Key(index.toString()),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              currentCategoryNotifier.setCurrentCategory(category);
              if (shouldPushDetails) {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, anim2) =>
                        CategoryScreen(category: category, heroId: category.id),
                    transitionsBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            child: Hero(
              tag: 'main${category.id}',
              child: Transform.scale(
                scale: needsDecoration ? 1.03 : 1,
                child: Card(
                  elevation: needsDecoration ? 1 : 1,
                  margin: EdgeInsets.zero,
                  shape: needsDecoration
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: category.color,
                            width: 4,
                            strokeAlign: -4,
                          ),
                        )
                      : null,
                  child: Padding(
                    padding: needsDecoration
                        ? const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16,
                          )
                        : const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: CategoryElement(category),
                          ),
                          ReorderableDragStartListener(
                            index: index,
                            child: MetaData(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const VerticalDivider(),
                                  CategoryMenu(
                                    category: category,
                                    canDeleteCategory: true,
                                    iconSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {},
      proxyDecorator: proxyDecorator,
    );
  }
}
