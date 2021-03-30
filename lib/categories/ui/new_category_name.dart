import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';

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
    return Scaffold(
      backgroundColor: Color(color),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 500,
          child: Card(
            margin: const EdgeInsets.all(32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          newCategory,
                          style: CustomStyles().textStyleTitle,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 4.0),
                        child: CupertinoTextField(
                          autofocus: true,
                          controller: textEditingController,
                          textInputAction: TextInputAction.done,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          onSubmitted: (_) =>
                              textEditingController.text.isNotEmpty
                                  ? onSubmitted()
                                  : null,
                          style: Theme.of(context).textTheme.headline4,
                          decoration: CustomStyles().inputDecoration,
                        ),
                      ),
                      Text(
                        categoryName,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SimpleButton(
                              text: cancel,
                              onPressed: onCancel,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SimpleButton(
                              text: next,
                              color: Colors.green,
                              onPressed: textEditingController.text.isNotEmpty
                                  ? onNext
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
