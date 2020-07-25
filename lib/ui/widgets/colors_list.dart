import 'package:flutter/material.dart';
import 'package:to_do/globals/category_colors.dart';

class ColorsList extends StatelessWidget {
  final bool visible;

  ColorsList({
    Key key,
    this.visible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryColors.length,
      itemBuilder: (context, index) {
        return AnimatedPadding(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          padding: EdgeInsets.symmetric(horizontal: visible ? 8.0 : 100.0),
          child: Container(
            color: Colors.grey[300],
            width: 40.0,
            height: 40.0,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                width: 28,
                height: 28,
                color: Color(categoryColors[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
