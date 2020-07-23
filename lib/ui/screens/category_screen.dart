import 'package:flutter/material.dart';
import 'package:to_do/ui/widgets/category_header.dart';

class CategoryScreen extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String name;

  const CategoryScreen({
    Key key,
    this.color,
    this.icon,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[850], color, color],
          ),
        ),
        child: Stack(
          children: [
            Hero(
              tag: 'main$color',
              child: Container(
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 32.0,
              top: 16.0,
              child: Hero(
                tag: 'icon$color',
                child: Icon(
                  icon,
                  color: color,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              left: 32.0,
              top: 72.0,
              right: 32.0,
              child: Hero(
                tag: 'header$color',
                child: Material(
                  type: MaterialType.transparency,
                  child: CategoryHeader(
                    title: name,
                    description: '8 tasks',
                    progress: 0.6,
                    color: color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
