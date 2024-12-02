import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/categories/categories_controller.dart';
import '../../controllers/category/category_controller.dart';
import '../screens/screens.dart';
import 'category_element.dart';
import 'category_menu.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesNotifierProvider);
    final currentCategoryNotifier =
        ref.watch(categoryNotifierProvider.notifier);

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
          final scale = lerpDouble(1, 1.02, animValue);
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryElement(
                  categories[index],
                ),
              ),
            ),
          );
        },
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          key: Key(index.toString()),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              currentCategoryNotifier.setCurrentCategory(category);
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
                // MaterialPageRoute(builder: (context) => AboutDialog(),)
              );
            },
            child: Hero(
              tag: 'main${category.id}',
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
        );
      },
      onReorder: ref.read(categoriesNotifierProvider.notifier).reorder,
      proxyDecorator: proxyDecorator,
    );
  }
}
