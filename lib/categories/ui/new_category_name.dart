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
                        child: Text(newCategory),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                        child: CupertinoTextField(
                          autofocus: true,
                          controller: textEditingController,
                          textInputAction: TextInputAction.done,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          onSubmitted: onSubmitted as void Function(String)?,
                          style: Theme.of(context).textTheme.headline4,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(0.0, -2.0)),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 1.0)),
                              ]),
                        ),
                      ),
                      const SizedBox(height: 4.0),
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
                              onPressed: onNext,
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
