import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';
import 'new_category_base.dart';

class CategoryTasks extends StatelessWidget {
  CategoryTasks({
    Key? key,
    required this.name,
    required this.color,
    required this.onNext,
    required this.onCancel,
    required this.selectedIcon,
    required this.focusNode,
  }) : super(key: key);

  final String name;
  final int color;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int selectedIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      onCancel: onCancel,
      okButtonText: finish,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 32.0, 4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      IconData(
                        selectedIcon,
                        fontFamily: 'AntIcons',
                        fontPackage: 'ant_icons',
                      ),
                      color: Color(color),
                      size: 38,
                    ),
                  ),
                  Text(
                    name,
                    style: CustomStyles().textStyleBigName,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
                child: AddTaskField(
                  addTask: () {},
                )),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Task', // TODO use const string
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
