import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import 'widgets/widgets.dart';

class NewCategoryScreen extends StatelessWidget {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final state = watch(newCategoryControllerProvider);
        final controller = watch(newCategoryControllerProvider.notifier);
        if (state.status == NewCategoryStatus.initial) {
          return CategoryInitial(color: state.color);
        } else if (state.status == NewCategoryStatus.name) {
          return CategoryName(
            onNameChanged: controller.nameChanged,
            color: state.color,
            focusNode: _focusNode,
            onSubmitted: () {
              _focusNode.unfocus();
              FocusScope.of(context).requestFocus(_focusNode);
              controller.progressToColor();
            },
            onNext: controller.progressToColor,
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        } else if (state.status == NewCategoryStatus.color) {
          return CategoryColor(
            focusNode: _focusNode,
            name: state.name,
            color: state.color,
            selectedColor: state.color,
            onNext: controller.progressToIcon,
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        } else if (state.status == NewCategoryStatus.icon) {
          return CategoryIcon(
            focusNode: _focusNode,
            name: state.name,
            color: state.color,
            onNext: controller.progressToTasks,
            onCancel: () {
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        } else if (state.status == NewCategoryStatus.tasks) {
          return CategoryTasks(
            focusNode: _focusNode,
            name: state.name,
            color: state.color,
            onNext: () {
              Navigator.of(context).pop();
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
            selectedIcon: state.icon,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
