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
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
            ),
            // Go back button
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Hero(
                tag: 'menu$color',
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            // Category icon
            Positioned(
              left: 48.0,
              top: 72.0,
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
              left: 48.0,
              top: 128.0,
              right: 48.0,
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
