import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../globals/globals.dart';
import '../../bloc/new_category_cubit.dart';

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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryColors.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              horizontalOffset: 100,
              child: FadeInAnimation(
                child: Padding(
                  padding: (widget.selectedColor == categoryColors[index])
                      ? const EdgeInsets.symmetric(vertical: 10, horizontal: 4)
                      : const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                  child: SizedBox(
                    width: 70,
                    child: Card(
                      color: Color(categoryColors[index]),
                      elevation: (widget.selectedColor == categoryColors[index])
                          ? 6
                          : 1,
                      child: InkWell(
                        onFocusChange: (v) {
                          BlocProvider.of<NewCategoryCubit>(context)
                              .changeTempColor(categoryColors[index]);
                        },
                        onTap: () {
                          BlocProvider.of<NewCategoryCubit>(context)
                              .changeTempColor(categoryColors[index]);
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
            ),
          );
        },
      ),
    );
  }
}
