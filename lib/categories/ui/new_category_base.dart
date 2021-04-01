import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals/globals.dart';
import '../../ui/ui.dart';

class NewCategoryBase extends StatelessWidget {
  NewCategoryBase({
    Key? key,
    required this.customWidget,
    required this.color,
    this.onSubmitted,
    required this.onNext,
    required this.onCancel,
    this.textEditingController,
    this.okButtonText = next,
  }) : super(key: key);

  final Widget customWidget;
  final int color;
  final Function? onSubmitted;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final TextEditingController? textEditingController;
  final String okButtonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF303030),
                    Color(color),
                    Color(color),
                  ]),
            ),
          ),
          Center(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        newCategory,
                        style: CustomStyles().textStyleTitle,
                      ),
                    ),
                    customWidget,
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimpleButton(
                            text: cancel,
                            onPressed: onCancel,
                          ),
                          SimpleButton(
                            text: okButtonText,
                            color: Colors.green,
                            onPressed: onNext,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
