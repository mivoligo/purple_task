import 'package:flutter/cupertino.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                onSubmitted: (_) => onSubmitted(),
                onChanged: onNameChanged,
                style: CustomStyle.textStyle20,
                decoration: CustomStyle.inputDecoration,
              ),
            ),
            const Text(
              s.categoryName,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
