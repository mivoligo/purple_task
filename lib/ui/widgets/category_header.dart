import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final Color color;

  const CategoryHeader({
    Key key,
    this.title,
    this.description,
    this.progress,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(description),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 24),
        ),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                backgroundColor: Colors.grey[300],
              ),
            ),
            SizedBox(width: 8),
            Text('${(progress * 100).toInt()}%'),
          ],
        ),
      ],
    );
  }
}
