import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/widgets/animated_progress_bar.dart';
import '../../ui/widgets/category_header.dart';
import '../data/model/category.dart';

class CategoryElement extends StatelessWidget {
  const CategoryElement({
    Key? key,
    required this.category,
    required this.onTap,
    this.onHover,
    this.onFocusChange,
    this.isInVerticalList = false,
  }) : super(key: key);

  final Category category;
  final VoidCallback onTap;
  final Function? onHover;
  final Function? onFocusChange;
  final bool isInVerticalList;

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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onHover: (_) => onHover,
        onFocusChange: (_) => onFocusChange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isInVerticalList
              ? ShortView(
                  category: category,
                  descriptionText: _descriptionText,
                  completionProgress: _completionProgress)
              : TallView(
                  category: category,
                  descriptionText: _descriptionText,
                  completionProgress: _completionProgress,
                ),
        ),
      ),
    );
  }
}

class ShortView extends StatelessWidget {
  const ShortView({
    Key? key,
    required this.category,
    required String descriptionText,
    required double completionProgress,
  })  : _descriptionText = descriptionText,
        _completionProgress = completionProgress,
        super(key: key);

  final Category category;
  final String _descriptionText;
  final double _completionProgress;

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
                  color: category.color,
                ),
              ),
              const SizedBox(width: 8),
              Text('${(_completionProgress * 100).toInt()}%'),
            ],
          ),
        ),
      ],
    );
  }
}

class TallView extends StatelessWidget {
  const TallView({
    Key? key,
    required this.category,
    required String descriptionText,
    required double completionProgress,
  })  : _descriptionText = descriptionText,
        _completionProgress = completionProgress,
        super(key: key);

  final Category category;
  final String _descriptionText;
  final double _completionProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Icon(
                IconData(
                  category.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 42.0,
                color: category.color,
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CategoryHeader(
            title: category.name,
            description: _descriptionText,
            progress: _completionProgress,
            color: category.color,
          ),
        ),
      ],
    );
  }
}
