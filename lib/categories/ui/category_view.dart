import 'package:flutter/material.dart';

import '../../db_models/category.dart';
import '../../ui/ui.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key, required this.category}) : super(key: key);

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
                color: Color(category.color),
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
              color: Color(category.color),
            ),
          ),
          AddTaskField(addTask: () {}),
        ],
      ),
    );
  }
}
