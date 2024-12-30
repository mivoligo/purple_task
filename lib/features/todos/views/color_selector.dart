import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/constants/category_colors.dart';
import '../../../core/helpers.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    required this.selectedColor,
    required this.onSelect,
  });

  final Color selectedColor;

  final ValueChanged<Color> onSelect;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => scrollController.animateTo(
        78.0 * categoryColors.indexOf(widget.selectedColor.intValue) - 40,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: categoryColors.length,
          itemBuilder: (context, index) {
            final color = Color(categoryColors[index]);

            final isSelected = color == widget.selectedColor;
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 300),
              child: SlideAnimation(
                horizontalOffset: 100,
                child: FadeInAnimation(
                  child: Padding(
                    padding: isSelected
                        ? const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 4,
                          )
                        : const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 4,
                          ),
                    child: SizedBox(
                      width: 70,
                      child: Card(
                        color: color,
                        elevation: isSelected ? 4 : 1,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          autofocus: isSelected,
                          onFocusChange: (_) => widget.onSelect(color),
                          onTap: () => widget.onSelect(color),
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
      ),
    );
  }
}
