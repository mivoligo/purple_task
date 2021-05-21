import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../category/widgets/widgets.dart';

class SelectedCategoryTasks extends StatefulWidget {
  const SelectedCategoryTasks({
    required this.category,
    required this.width,
    required this.height,
  });

  final Category category;
  final double width;
  final double height;

  @override
  _SelectedCategoryTasksState createState() => _SelectedCategoryTasksState();
}

class _SelectedCategoryTasksState extends State<SelectedCategoryTasks> {
  late int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: CustomStyle.uncategorizedTasksDecoration,
      child: Column(
        children: [
          Consumer(builder: (context, watch, _) {
            final currentCategory =
                watch(categoryProvider(widget.category)).category;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTasksList(currentCategory),
              ),
            );
          }),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 14.0,
            currentIndex: _navigationIndex,
            onTap: (index) {
              setState(() {
                _navigationIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                label: s.toDo,
                icon: Icon(AntIcons.edit),
              ),
              const BottomNavigationBarItem(
                label: s.all,
                icon: Icon(AntIcons.profile),
              ),
              const BottomNavigationBarItem(
                label: s.completed,
                icon: Icon(AntIcons.check_circle),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTasksList(Category category) {
    switch (_navigationIndex) {
      case 0:
        return PlannedTasks(categoryId: category.id);
      case 1:
        return AllTasks(categoryId: category.id);
      case 2:
        return CompletedTasks(categoryId: category.id);
      default:
        return PlannedTasks(categoryId: category.id);
    }
  }
}
