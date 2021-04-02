import 'package:flutter/material.dart';

import '../../db_models/db_models.dart';
import '../../globals/globals.dart';
import '../../ui/widgets/animated_progress_bar.dart';

class CategoryElement extends StatelessWidget {
  const CategoryElement({
    Key? key,
    required this.category,
    this.onTap,
    this.onHover,
    this.onFocusChange,
  }) : super(key: key);

  final Category category;
  final VoidCallback? onTap;
  final Function? onHover;
  final Function? onFocusChange;

  @override
  Widget build(BuildContext context) {
    String _descriptionText;
    final _numberOfTasks = 3;
    final _completionProgress = 0.4;
    // final _numberOfTasks = Provider.of<TaskViewModel>(context, listen: false)
    //     .numberOfPlannedTasksForCategory(category!.id);
    // final _completionProgress =
    // Provider.of<TaskViewModel>(context).completionProgress(category!.id);
    switch (_numberOfTasks) {
      case 0:
        _descriptionText = '$_numberOfTasks $taskPlural';
        break;
      case 1:
        _descriptionText = '$_numberOfTasks $taskSingular';
        break;
      default:
        _descriptionText = '$_numberOfTasks $taskPlural';
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                    color: Color(category.color),
                  ),
                ),
                Text(
                  '${category.name}',
                  style: CustomStyles().textStyleBigName,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 12, right: 8),
              child: Text(_descriptionText),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedProgressBar(
                      value: _completionProgress,
                      color: Color(category.color),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(_completionProgress * 100).toInt()}%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
