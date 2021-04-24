import 'package:flutter/material.dart';

import '../../ui/ui.dart';
import '../data/models/category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 42.0,
                color: category.color,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 4.0,
            ),
            child: CategoryHeader(
              title: category.name,
              description: 'sdada',
              progress: 0.3,
              color: category.color,
            ),
          ),
          AddTaskField(addTask: () {}),
        ],
      ),
    );
  }
}
