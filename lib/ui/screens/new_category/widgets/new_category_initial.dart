import 'package:flutter/material.dart';

class CategoryInitial extends StatelessWidget {
  CategoryInitial({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

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
                    const Color(0xFF303030),
                    color,
                    color,
                  ]),
            ),
          ),
          Center(
            child: Hero(
              tag: 'new_category',
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
