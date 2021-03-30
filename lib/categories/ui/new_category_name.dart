import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';

class CategoryName extends StatelessWidget {
  CategoryName({
    Key? key,
    required this.color,
    this.onSubmitted,
    required this.onNext,
    required this.onCancel,
    required this.textEditingController,
  }) : super(key: key);

  // final Function onTextChanged;
  final int color;
  final Function? onSubmitted;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(color),
      body: Card(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                    child: CupertinoTextField(
                      autofocus: true,
                      controller: textEditingController,
                      textInputAction: TextInputAction.done,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      onSubmitted: onSubmitted as void Function(String)?,
                      style: Theme.of(context).textTheme.headline4,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(0.0, -2.0)),
                            BoxShadow(
                                color: Colors.white, offset: Offset(0.0, 1.0)),
                          ]),
                      // onChanged: (_) {
                      //   print(textEditingController.text);
                      // },
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    categoryName,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      const SizedBox(width: 16.0),
                      SimpleButton(
                        text: cancel,
                        onPressed: onCancel,
                      ),
                      Spacer(),
                      SimpleButton(
                        text: next,
                        color: Colors.green,
                        onPressed: onNext,
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
