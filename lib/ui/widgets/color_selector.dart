import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../controllers/controllers.dart';
import '../../globals/globals.dart' as g;
import '../../models/models.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    required this.selectedColor,
    this.isInCreator = true,
    this.category,
  });

  final Color selectedColor;
  final bool isInCreator;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: g.categoryColors.length,
        itemBuilder: (context, index) {
          final isSelected = selectedColor == Color(g.categoryColors[index]);
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
                      color: Color(g.categoryColors[index]),
                      elevation: isSelected ? 6 : 1,
                      child: InkWell(
                        onFocusChange: isInCreator
                            ? (_) => context
                                .read(newCategoryControllerProvider.notifier)
                                .colorChanged(Color(g.categoryColors[index]))
                            : (_) => context
                                .read(editCategoryProvider(category!).notifier)
                                .colorChanged(
                                    color: Color(g.categoryColors[index])),
                        onTap: isInCreator
                            ? () => context
                                .read(newCategoryControllerProvider.notifier)
                                .colorChanged(Color(g.categoryColors[index]))
                            : () => context
                                .read(editCategoryProvider(category!).notifier)
                                .colorChanged(
                                    color: Color(g.categoryColors[index])),
                        child: isSelected
                            ? const Icon(
                                AntIcons.check_outline,
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
