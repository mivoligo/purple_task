import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/category_colors.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';

class ColorSelector extends StatefulWidget {
  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<EdgeInsets> _padding;

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
    final categoryProvider =
        Provider.of<CategoryViewModel>(context, listen: false);
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
          child: Container(
            width: 64,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                categoryProvider.color = categoryColors[index];
              },
              child: Container(
                width: 64,
                color: Color(categoryColors[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
