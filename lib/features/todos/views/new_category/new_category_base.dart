import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class NewCategoryBase extends StatelessWidget {
  const NewCategoryBase({
    required this.customWidget,
    required this.color,
    required this.onNext,
    required this.focusNode,
    this.textEditingController,
    this.okButtonText,
    super.key,
  });

  final Widget customWidget;
  final Color color;
  final VoidCallback onNext;
  final TextEditingController? textEditingController;
  final String? okButtonText;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
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
                ],
              ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          tr.newCategoryLabel,
                          style: CustomStyle.textStyleTitle,
                        ),
                      ),
                      customWidget,
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleButton(
                              text: tr.cancelButton,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SimpleButton(
                              text: okButtonText ?? tr.nextButton,
                              backgroundColor: Colors.green,
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
