import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:to_do/ui/widgets/category_header.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final String editTooltip;

  final VoidCallback onTap;

  const CategoryCard({
    Key key,
    this.name,
    this.color,
    this.icon,
    this.editTooltip,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Stack(
        children: [
          Hero(
            tag: 'main$name',
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff45000000),
                      offset: Offset(0.0, 4.0),
                      blurRadius: 8.0,
                    ),
                  ]),
            ),
          ),
          Positioned(
            left: 16.0,
            top: 16.0,
            child: Hero(
              tag: 'icon$name',
              child: Icon(
                icon,
                size: 40.0,
                color: color,
              ),
            ),
          ),
          Positioned(
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
            child: Hero(
              tag: 'header$name',
              child: Material(
                type: MaterialType.transparency,
                child: CategoryHeader(
                  title: name,
                  color: color,
                  description: '8 tasks',
                  progress: 0.6,
                ),
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Hero(
              tag: 'menu$name',
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(AntIcons.menu),
                  color: Colors.grey,
                  tooltip: editTooltip,
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
