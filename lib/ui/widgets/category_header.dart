import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'widgets.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    Key? key,
    required this.title,
    required this.description,
    required this.progress,
    required this.color,
  }) : super(key: key);

  final String? title;
  final String description;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // number of tasks to do
        Text(
          description,
          style: CustomStyle.textStyleTaskName,
        ),
        const SizedBox(height: 8.0),
        // category name
        Text(
          title!,
          overflow: TextOverflow.ellipsis,
          style: CustomStyle.textStyle24,
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
