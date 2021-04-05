import 'package:flutter/material.dart';

class CategoryInitial extends StatelessWidget {
  CategoryInitial({
    Key? key,
    required this.color,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF303030),
                    Color(color),
                    Color(color),
                  ]),
            ),
          ),
          Center(
            child: Hero(
              tag: 'addCategoryHero',
              child: SizedBox(
                width: 600,
                height: 500,
                child: Card(
                  margin: const EdgeInsets.all(32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
