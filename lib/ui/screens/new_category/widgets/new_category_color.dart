import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';
import 'new_category_base.dart';

class CategoryColor extends StatelessWidget {
  CategoryColor({
    Key? key,
    required this.name,
    required this.color,
    required this.onNext,
    required this.selectedColor,
    required this.focusNode,
  }) : super(key: key);

  final String name;
  final Color color;
  final VoidCallback onNext;
  final Color selectedColor;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      focusNode: focusNode,
      color: color,
      onNext: onNext,
      customWidget: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 20.0, 32.0, 4.0),
              child: Text(
                name,
                style: CustomStyle.textStyle24,
              ),
            ),
            Expanded(
              child: ColorSelector(
                selectedColor: selectedColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                s.color,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
