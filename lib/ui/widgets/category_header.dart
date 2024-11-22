import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import 'widgets.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    Key? key,
    required this.title,
    required this.description,
    required this.progress,
    required this.color,
    required this.category,
  }) : super(key: key);

  final String? title;
  final String description;
  final double progress;
  final Color color;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 42.0,
                color: category.color,
              ),
            ),
            Text(
              title!,
              overflow: TextOverflow.ellipsis,
              style: CustomStyle.textStyle24,
            ),
          ],
        ),
        Text(
          description,
          style: CustomStyle.textStyleTaskName,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: AnimatedProgressBar(
                value: progress,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text('${(progress * 100).toInt()}%'),
          ],
        ),
      ],
    );
  }
}
