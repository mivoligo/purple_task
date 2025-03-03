import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/todos/views/new_category/new_category_screen.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tr = AppLocalizations.of(context);
    return Hero(
      tag: 'new_category',
      child: SimpleButton(
        text: tr.addCategoryButton,
        onPressed: () => Navigator.of(context).push(
          _createRoute(NewCategoryScreen()),
        ),
        icon: Icon(AntIcons.folderAdd, color: colorScheme.onSurface),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
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
