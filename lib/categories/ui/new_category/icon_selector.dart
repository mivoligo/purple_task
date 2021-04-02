import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../globals/globals.dart';
import '../../bloc/new_category_cubit.dart';

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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              horizontalOffset: 100,
              child: FadeInAnimation(
                child: Padding(
                  padding: (widget.selectedIcon == categoryIcons[index])
                      ? const EdgeInsets.symmetric(vertical: 10, horizontal: 4)
                      : const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                  child: SizedBox(
                    width: 70,
                    child: Card(
                      color: Colors.grey.shade300,
                      elevation:
                          (widget.selectedIcon == categoryIcons[index]) ? 6 : 1,
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
            ),
          );
        },
      ),
    );
  }
}
