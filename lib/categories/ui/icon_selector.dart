import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../globals/globals.dart';
import '../bloc/new_category_cubit.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({
    Key? key,
    required this.selectedIcon,
  }) : super(key: key);

  final int selectedIcon;

  @override
  _IconSelectorState createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 3,
            duration: const Duration(milliseconds: 300),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Padding(
                  padding: (widget.selectedIcon == categoryIcons[index])
                      ? const EdgeInsets.all(4.0)
                      : const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey.shade300,
                    elevation:
                        (widget.selectedIcon == categoryIcons[index]) ? 4 : 2,
                    child: InkWell(
                      onFocusChange: (v) {
                        BlocProvider.of<NewCategoryCubit>(context)
                            .changeTempIcon(categoryIcons[index]);
                      },
                      onTap: () {
                        BlocProvider.of<NewCategoryCubit>(context)
                            .changeTempIcon(categoryIcons[index]);
                      },
                      child: Icon(
                        IconData(
                          categoryIcons[index],
                          fontFamily: 'AntIcons',
                          fontPackage: 'ant_icons',
                        ),
                        color: Colors.grey.shade800,
                        size: (widget.selectedIcon == categoryIcons[index])
                            ? 30
                            : 24,
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
