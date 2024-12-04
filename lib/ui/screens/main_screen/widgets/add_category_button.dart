import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../widgets/simple_button.dart';
import '../../screens.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'new_category',
      child: SimpleButton(
        text: 'Add new',
        onPressed: () => Navigator.of(context).push(
          _createRoute(NewCategoryScreen()),
        ),
        icon: const Icon(AntIcons.folderAdd),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
    );
  }

  Route _createRoute(Widget target) {
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
