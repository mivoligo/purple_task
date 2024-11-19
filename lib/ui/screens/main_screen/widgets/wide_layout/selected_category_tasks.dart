import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
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
          Consumer(
            builder: (context, ref, _) {
              final currentCategory = widget.category;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTasksList(currentCategory),
                ),
              );
            },
          ),
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
                icon: Icon(AntIcons.checkCircle),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(Category category) {
    return switch (_navigationIndex) {
      0 => PlannedTasks(categoryId: category.id),
      1 => AllTasks(categoryId: category.id),
      2 => CompletedTasks(categoryId: category.id),
      _ => PlannedTasks(categoryId: category.id)
    };
  }
}
