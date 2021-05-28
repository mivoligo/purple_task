import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;

import 'new_category_base.dart';

class CategoryName extends StatelessWidget {
  CategoryName({
    Key? key,
    required this.onNameChanged,
    required this.color,
    required this.onSubmitted,
    required this.onNext,
    required this.focusNode,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Color color;
  final Function onSubmitted;
  final VoidCallback onNext;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onSubmitted: onSubmitted,
      onNext: onNext,
      customWidget: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
              child: CupertinoTextField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                onSubmitted: (_) => onSubmitted(),
                onChanged: onNameChanged,
                style: CustomStyle.textStyle24,
                decoration: CustomStyle.inputDecoration,
              ),
            ),
            Text(
              s.categoryName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
