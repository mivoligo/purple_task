import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../globals/category_icons.dart';
import '../../view_models/new_category_view_model.dart';

class IconsList extends StatefulWidget {
  @override
  _IconsListState createState() => _IconsListState();
}

class _IconsListState extends State<IconsList>
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
    final newCategoryProvider =
        Provider.of<NewCategoryViewModel>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryIcons.length,
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
            color: Colors.grey[300],
            width: 64.0,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                newCategoryProvider.icon = categoryIcons[index];
              },
              child: Icon(
                IconData(
                  categoryIcons[index],
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
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
