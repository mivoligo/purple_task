import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../globals/globals.dart';
import 'color_selector.dart';
import 'new_category_base.dart';

class CategoryColor extends StatelessWidget {
  CategoryColor({
    Key? key,
    required this.name,
    required this.color,
    required this.onNext,
    required this.onCancel,
    required this.selectedColor,
    required this.focusNode,
  }) : super(key: key);

  final String name;
  final Color color;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final Color selectedColor;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      onCancel: onCancel,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 20.0, 32.0, 4.0),
              child: Text(
                name,
                style: CustomStyles().textStyleBigName,
              ),
            ),
            Expanded(
              child: ColorSelector(
                selectedColor: selectedColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Color', // TODO use const string
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
