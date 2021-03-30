import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _ColorSelectorState extends State<ColorSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<EdgeInsets> _padding;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _padding = EdgeInsetsTween(
      begin: EdgeInsets.symmetric(horizontal: 100.0),
      end: EdgeInsets.symmetric(horizontal: 4.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryColors.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Padding(
              padding: _padding.value,
              child: child,
            );
          },
          child: Material(
            child: InkWell(
              onFocusChange: (v) {
                BlocProvider.of<NewCategoryCubit>(context)
                    .changeColor(categoryColors[index]);
              },
              onTap: () {
                BlocProvider.of<NewCategoryCubit>(context)
                    .changeColor(categoryColors[index]);
              },
              child: Container(
                width: 64,
                color: Color(categoryColors[index]),
                child: (widget.selectedColor == categoryColors[index])
                    ? Icon(
                        AntIcons.check_outline,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
