import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/features/todos/views/new_category/new_category_base.dart';

class CategoryName extends StatelessWidget {
  const CategoryName({
    required this.onNameChanged,
    required this.color,
    required this.onSubmitted,
    required this.onNext,
    required this.focusNode,
    super.key,
  });

  final void Function(String) onNameChanged;
  final Color color;
  final VoidCallback onSubmitted;
  final VoidCallback onNext;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tr = AppLocalizations.of(context);
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      customWidget: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 4),
              child: CupertinoTextField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                padding: const EdgeInsets.all(8),
                onSubmitted: (_) => onSubmitted(),
                onChanged: onNameChanged,
                style: CustomStyle.textStyle20
                    .copyWith(color: colorScheme.onSurface),
                decoration: CustomStyle.inputDecoration.copyWith(
                  color: colorScheme.surface,
                ),
              ),
            ),
            Text(
              tr.categoryNameLabel,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
