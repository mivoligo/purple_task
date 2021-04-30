import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../globals/globals.dart';
import '../../../view_models/view_models.dart';

class ColorSelectorOld extends StatefulWidget {
  @override
  _ColorSelectorOldState createState() => _ColorSelectorOldState();
}

class _ColorSelectorOldState extends State<ColorSelectorOld>
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
    final categoryProvider = Provider.of<CategoryViewModel>(context);
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
                categoryProvider.color = Color(categoryColors[index]);
              },
              onTap: () {
                categoryProvider.color = Color(categoryColors[index]);
              },
              child: Container(
                width: 64,
                color: Color(categoryColors[index]),
                child: (categoryProvider.color == categoryColors[index])
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
