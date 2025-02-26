import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/features/todos/controllers/new_category_controller.dart';
import 'package:purple_task/features/todos/views/icon_selector.dart';
import 'package:purple_task/features/todos/views/new_category/new_category_base.dart';

class CategoryIcon extends ConsumerWidget {
  const CategoryIcon({
    required this.name,
    required this.color,
    required this.onNext,
    required this.selectedIcon,
    required this.focusNode,
    super.key,
  });

  final String name;
  final Color color;
  final VoidCallback onNext;
  final int selectedIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 32, 4),
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
                      color: color,
                      size: 38,
                    ),
                  ),
                  Text(
                    name,
                    style: CustomStyle.textStyle24.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IconSelector(
                selectedIcon: selectedIcon,
                onSelect:
                    ref.read(newCategoryNotifierProvider.notifier).changeIcon,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                s.icon,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
