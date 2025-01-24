import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:purple_task/core/constants/strings/strings.dart';

import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/todos/views/new_category/new_category_screen.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'new_category',
      child: SimpleButton(
        text: addCategory,
        onPressed: () => Navigator.of(context).push(
          _createRoute(NewCategoryScreen()),
        ),
        icon: const Icon(AntIcons.folderAdd, color: Colors.black87),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
    );
  }

  Route<void> _createRoute(Widget target) {
    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => target,
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}
