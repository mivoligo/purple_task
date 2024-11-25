import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/constants.dart';
import '../../controllers/controllers.dart';

class IconSelector extends ConsumerWidget {
  const IconSelector({
    required this.selectedIcon,
    this.isInCreator = true,
  });

  final int selectedIcon;
  final bool isInCreator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryNotifierProvider);

    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          final isSelected = category?.icon == categoryIcons[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              horizontalOffset: 100,
              child: FadeInAnimation(
                child: Padding(
                  padding: isSelected
                      ? const EdgeInsets.symmetric(vertical: 10, horizontal: 4)
                      : const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                  child: SizedBox(
                    width: 70,
                    child: Card(
                      color: Colors.grey.shade300,
                      elevation: isSelected ? 6 : 1,
                      child: InkWell(
                        onFocusChange: isInCreator
                            ? (_) => ref
                                .read(newCategoryNotifierProvider.notifier)
                                .changeIcon(categoryIcons[index])
                            : (_) => ref
                                .read(categoryNotifierProvider.notifier)
                                .changeIcon(icon: categoryIcons[index]),
                        onTap: isInCreator
                            ? () => ref
                                .read(newCategoryNotifierProvider.notifier)
                                .changeIcon(categoryIcons[index])
                            : () => ref
                                .read(categoryNotifierProvider.notifier)
                                .changeIcon(icon: categoryIcons[index]),
                        child: Icon(
                          IconData(
                            categoryIcons[index],
                            fontFamily: 'AntIcons',
                            fontPackage: 'ant_icons',
                          ),
                          color: Colors.grey.shade800,
                          size: isSelected ? 30 : 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
