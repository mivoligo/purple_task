import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/ui/widgets/icon_button.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/views/category_menu.dart';

class CategoryTopBar extends StatelessWidget {
  const CategoryTopBar({
    required this.onClose,
    required this.category,
    super.key,
  });

  final VoidCallback onClose;
  final Category category;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Go back button
        CustomIconButton(
          icon: const Icon(AntIcons.close),
          color: Theme.of(context).colorScheme.onSurface,
          tooltip: tr.closeButton,
          onPressed: () {
            onClose();
            Navigator.of(context).pop();
          },
        ),
        // Menu button
        CategoryMenu(
          category: category,
          canDeleteCategory: false,
        ),
      ],
    );
  }
}
