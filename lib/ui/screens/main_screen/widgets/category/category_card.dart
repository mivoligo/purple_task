import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../controllers/controllers.dart';
import '../../../../../globals/globals.dart';
import '../../../../../globals/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../widgets/animated_progress_bar.dart';
import '../../../../widgets/category_header.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
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
    switch (_numberOfTasks) {
      case 0:
        _descriptionText = '$_numberOfTasks ${s.taskPlural}';
        break;
      case 1:
        _descriptionText = '$_numberOfTasks ${s.taskSingular}';
        break;
      default:
        _descriptionText = '$_numberOfTasks ${s.taskPlural}';
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(categoryCardProvider(category.id));

          return InkWell(
            onTap: onTap,
            onHover: (_) => onHover,
            onFocusChange: (_) => onFocusChange,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isInVerticalList
                  ? ShortView(
                      category: category,
                      descriptionText: '${state.activeTasksNumber}',
                      completionProgress: state.progress)
                  : TallView(
                      category: category,
                      descriptionText: '${state.activeTasksNumber}',
                      completionProgress: state.progress,
                    ),
            ),
          );
        },
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
              style: CustomStyle.textStyleBigName,
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
        const Spacer(),
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
