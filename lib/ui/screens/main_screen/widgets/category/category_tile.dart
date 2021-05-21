import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../../widgets/widgets.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
    this.onHover,
    this.onFocusChange,
  }) : super(key: key);

  final Category category;
  final VoidCallback onTap;
  final Function? onHover;
  final Function? onFocusChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Consumer(
        builder: (context, watch, _) {
          final progress = watch(progressProvider(category.id));
          var description = '';
          final activeTasksNumber = watch(
            activeTasksNumberProvider(category.id),
          );
          switch (activeTasksNumber) {
            case 0:
              description = '$activeTasksNumber ${s.taskPlural}';
              break;
            case 1:
              description = '$activeTasksNumber ${s.taskSingular}';
              break;
            default:
              description = '$activeTasksNumber ${s.taskPlural}';
          }
          return InkWell(
            onTap: onTap,
            onHover: (_) => onHover,
            onFocusChange: (_) => onFocusChange,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _ShortView(
                  category: category,
                  descriptionText: description,
                  completionProgress: progress,
                )),
          );
        },
      ),
    );
  }
}

class _ShortView extends StatelessWidget {
  const _ShortView({
    Key? key,
    required this.category,
    required this.descriptionText,
    required this.completionProgress,
  }) : super(key: key);

  final Category category;
  final String descriptionText;
  final double completionProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 38.0,
                color: category.color,
              ),
            ),
            Text(
              '${category.name}',
              style: CustomStyle.textStyle20,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, top: 12, right: 8),
          child: Text(descriptionText),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                child: AnimatedProgressBar(
                  value: completionProgress,
                  color: category.color,
                ),
              ),
              const SizedBox(width: 8),
              Text('${(completionProgress * 100).toInt()}%'),
            ],
          ),
        ),
      ],
    );
  }
}
