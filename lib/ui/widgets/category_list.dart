import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/categories/categories_controller.dart';
import 'category_element.dart';
import 'category_menu.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesNotifierProvider);

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
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Card(
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
                              onRemoveCategory: () {},
                              onRemoveAllTasks: () {},
                              onRemoveCompletedTasks: () {},
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
        );
      },
      onReorder: (oldIndex, newIndex) {
        print('new index: $newIndex');
      },
      proxyDecorator: proxyDecorator,
    );
  }
}
