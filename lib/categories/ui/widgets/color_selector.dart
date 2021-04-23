import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../globals/globals.dart';
import '../../bloc/category_cubit.dart';
import '../../bloc/new_category_cubit.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    required this.selectedColor,
    this.isInCreator = true,
  });

  final Color selectedColor;
  final bool isInCreator;

  @override
  Widget build(BuildContext context) {
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
                            ? (_) => context
                                .read<NewCategoryCubit>()
                                .changeTempColor(Color(categoryColors[index]))
                            : (_) => context.read<CategoryCubit>().updateColor(
                                color: Color(categoryColors[index])),
                        onTap: isInCreator
                            ? () => context
                                .read<NewCategoryCubit>()
                                .changeTempColor(Color(categoryColors[index]))
                            : () => context.read<CategoryCubit>().updateColor(
                                color: Color(categoryColors[index])),
                        child: isSelected
                            ? Icon(
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
