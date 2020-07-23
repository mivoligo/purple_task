import 'package:flutter/material.dart';
import 'package:to_do/ui/widgets/category_header.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;
  final String editTooltip;

  final VoidCallback onTap;

  const CategoryCard({
    Key key,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
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
            tag: 'main$categoryColor',
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
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
              tag: 'icon$categoryColor',
              child: Icon(
                categoryIcon,
                size: 40.0,
                color: categoryColor,
              ),
            ),
          ),
          Positioned(
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
            child: Hero(
              tag: 'header$categoryColor',
              child: Material(
                type: MaterialType.transparency,
                child: CategoryHeader(
                  title: categoryName,
                  color: categoryColor,
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
              tag: 'menu$categoryColor',
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(Icons.menu),
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
