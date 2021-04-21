import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../db_models/db_models.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.category,
    this.onTap,
    this.onHover,
    this.onFocusChange,
  }) : super(key: key);

  final CategoryEntity? category;
  final VoidCallback? onTap;
  final Function? onHover;
  final Function? onFocusChange;

  @override
  Widget build(BuildContext context) {
    String _descriptionText;
    final _numberOfTasks = Provider.of<TaskViewModel>(context, listen: false)
        .numberOfPlannedTasksForCategory(category!.id);
    final _completionProgress =
        Provider.of<TaskViewModel>(context).completionProgress(category!.id);
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
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Stack(
        children: [
          Hero(
            tag: 'main${category!.id}',
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff45000000),
                      offset: Offset(0.0, 4.0),
                      blurRadius: 8.0,
                    ),
                  ]),
            ),
          ),
          Positioned(
            left: 16.0,
            top: 16.0,
            child: Hero(
              tag: 'icon${category!.id}',
              child: Icon(
                IconData(
                  category!.icon,
                  fontFamily: 'AntIcons',
                  fontPackage: 'ant_icons',
                ),
                size: 40.0,
                color: Color(category!.color),
              ),
            ),
          ),
          Positioned(
            left: 24.0,
            right: 24.0,
            bottom: 16.0,
            child: Hero(
              tag: 'header${category!.id}',
              child: Material(
                type: MaterialType.transparency,
                child: CategoryHeader(
                  title: category!.name,
                  color: Color(category!.color),
                  description: _descriptionText,
                  progress: _completionProgress,
                ),
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(12.0),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              onHover: onHover as void Function(bool)?,
              onFocusChange: onFocusChange as void Function(bool)?,
            ),
          ),
        ],
      ),
    );
  }
}
