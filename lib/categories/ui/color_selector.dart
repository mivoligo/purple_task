import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../globals/globals.dart';
import '../bloc/new_category_cubit.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    Key? key,
    required this.selectedColor,
  }) : super(key: key);

  final int selectedColor;

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categoryColors.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 3,
            duration: const Duration(milliseconds: 300),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Padding(
                  padding: (widget.selectedColor == categoryColors[index])
                      ? const EdgeInsets.all(4.0)
                      : const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color(categoryColors[index]),
                    elevation:
                        (widget.selectedColor == categoryColors[index]) ? 4 : 2,
                    child: InkWell(
                      onFocusChange: (v) {
                        BlocProvider.of<NewCategoryCubit>(context)
                            .changeColor(categoryColors[index]);
                      },
                      onTap: () {
                        BlocProvider.of<NewCategoryCubit>(context)
                            .changeColor(categoryColors[index]);
                      },
                      child: (widget.selectedColor == categoryColors[index])
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
          );
        },
      ),
    );
  }
}
