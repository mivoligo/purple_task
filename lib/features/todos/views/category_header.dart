import 'package:flutter/material.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/ui/widgets/animated_progress_bar.dart';
import 'package:purple_task/features/todos/models/category.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    required this.title,
    required this.description,
    required this.progress,
    required this.color,
    required this.category,
    super.key,
  });

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
                size: 42,
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
        const SizedBox(height: 8),
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
