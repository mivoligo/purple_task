import 'package:flutter/material.dart';

import '../../../../globals/globals.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';

class NewCategoryBase extends StatelessWidget {
  NewCategoryBase({
    Key? key,
    required this.customWidget,
    required this.color,
    this.onSubmitted,
    required this.onNext,
    required this.onCancel,
    this.textEditingController,
    this.okButtonText = s.next,
    required this.focusNode,
  }) : super(key: key);

  final Widget customWidget;
  final Color color;
  final Function? onSubmitted;
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final TextEditingController? textEditingController;
  final String okButtonText;
  final FocusNode focusNode;

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
                    const Color(0xFF303030),
                    color,
                    color,
                  ]),
            ),
          ),
          Center(
            child: Hero(
              tag: 'new_category',
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          s.newCategory,
                          style: CustomStyle.textStyleTitle,
                        ),
                      ),
                      customWidget,
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleButton(
                              text: s.cancel,
                              onPressed: onCancel,
                            ),
                            SimpleButton(
                              text: okButtonText,
                              color: Colors.green,
                              onPressed: onNext,
                              focusNode: focusNode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
