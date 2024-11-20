import 'package:flutter/material.dart';

import 'animated_progress_bar.dart';

class CategoryElementBase extends StatelessWidget {
  const CategoryElementBase({
    super.key,
    required this.icon,
    required this.name,
    required this.description,
    required this.progress,
    required this.color,
  });

  final int icon;
  final String name;
  final String description;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              IconData(
                icon,
                fontFamily: 'AntIcons',
                fontPackage: 'ant_icons',
              ),
              color: color,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        Row(
          children: [
            Expanded(child: AnimatedProgressBar(color: color, value: progress)),
            const SizedBox(width: 8),
            Text('${(progress * 100).toInt()}%'),
          ],
        ),
      ],
    );
  }
}
