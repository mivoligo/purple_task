import 'package:flutter/material.dart';
import '../ui.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final Color color;

  const CategoryHeader({
    Key key,
    @required this.title,
    @required this.description,
    @required this.progress,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // number of tasks to do
        Text(
          description,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 8.0),
        // category name
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline4,
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
