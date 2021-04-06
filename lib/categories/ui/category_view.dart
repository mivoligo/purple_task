import 'package:flutter/material.dart';

import '../../db_models/category.dart';
import '../../ui/ui.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(),
        Icon(
          IconData(
            category.icon,
            fontFamily: 'AntIcons',
            fontPackage: 'ant_icons',
          ),
          size: 38.0,
          color: Color(category.color),
        ),
        Text('data'),
        Text(category.name),
        AnimatedProgressBar(
          color: Color(category.color),
          value: 0.6,
        ),
        AddTaskField(addTask: () {}),
      ],
    );
  }
}
