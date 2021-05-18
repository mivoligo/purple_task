import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';

class IconSelector extends StatelessWidget {
  const IconSelector({
    required this.selectedIcon,
    this.isInCreator = true,
    this.category,
  });

  final int selectedIcon;
  final bool isInCreator;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIcon == categoryIcons[index];
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
                            ? (_) => context
                                .read(newCategoryControllerProvider.notifier)
                                .iconChanged(categoryIcons[index])
                            : (_) => context
                                .read(categoryProvider(category!).notifier)
                                .iconChanged(icon: categoryIcons[index]),
                        onTap: isInCreator
                            ? () => context
                                .read(newCategoryControllerProvider.notifier)
                                .iconChanged(categoryIcons[index])
                            : () => context
                                .read(categoryProvider(category!).notifier)
                                .iconChanged(icon: categoryIcons[index]),
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
