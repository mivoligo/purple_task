import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/category_icons.dart';
import 'package:to_do/ui/view_models/category_model.dart';

class IconsList extends StatelessWidget {
  final bool visible;
  final VoidCallback onSelected;

  IconsList({
    Key key,
    this.visible = false,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newCategoryProvider =
        Provider.of<NewCategory>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryIcons.length,
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
              onPressed: () {
                newCategoryProvider.icon = categoryIcons[index];
                onSelected();
              },
              child: Icon(
                categoryIcons[index],
                color: Colors.black54,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}
