import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';

class ColorSelector extends ConsumerWidget {
  const ColorSelector({
    required this.selectedColor,
    this.isInCreator = true,
    this.category,
  });

  final Color selectedColor;
  final bool isInCreator;
  final Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryColors.length,
        itemBuilder: (context, index) {
          final isSelected = selectedColor == Color(categoryColors[index]);
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
                      color: Color(categoryColors[index]),
                      elevation: isSelected ? 6 : 1,
                      child: InkWell(
                        onFocusChange: isInCreator
                            ? (_) => ref
                                .read(newCategoryNotifierProvider.notifier)
                                .changeColor(Color(categoryColors[index]))
                            : (_) => ref
                                .read(categoryNotifierProvider.notifier)
                                .changeColor(
                                    color: Color(categoryColors[index])),
                        onTap: isInCreator
                            ? () => ref
                                .read(newCategoryNotifierProvider.notifier)
                                .changeColor(Color(categoryColors[index]))
                            : () => ref
                                .read(categoryNotifierProvider.notifier)
                                .changeColor(
                                    color: Color(categoryColors[index])),
                        child: isSelected
                            ? const Icon(
                                AntIcons.checkOutline,
                                color: Colors.white,
                              )
                            : null,
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
