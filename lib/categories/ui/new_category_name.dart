import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import 'new_category_base.dart';

class CategoryName extends StatelessWidget {
  CategoryName({
    Key? key,
    required this.color,
    required this.onSubmitted,
    required this.onNext,
    required this.onCancel,
    required this.textEditingController,
  }) : super(key: key);

  final int color;
  final Function onSubmitted;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return NewCategoryBase(
      color: color,
      onSubmitted: onSubmitted,
      onNext: () => textEditingController.text.isNotEmpty ? onNext() : null,
      onCancel: onCancel,
      textEditingController: textEditingController,
      customWidget: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
              child: CupertinoTextField(
                autofocus: true,
                controller: textEditingController,
                textInputAction: TextInputAction.done,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                onSubmitted: (_) => textEditingController.text.isNotEmpty
                    ? onSubmitted()
                    : null,
                style: CustomStyles().textStyleBigName,
                decoration: CustomStyles().inputDecoration,
              ),
            ),
            Text(
              categoryName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
