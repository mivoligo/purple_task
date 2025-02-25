import 'package:flutter/material.dart';

import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.confirmationText,
    required this.onConfirm,
    super.key,
    this.content,
    this.confirmationColor = Colors.green,
    this.onCancel,
  });

  final String title;
  final Widget? content;
  final String confirmationText;
  final Color confirmationColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      title: Text(
        title,
        style: CustomStyle.textStyle24,
      ),
      content: content,
      buttonPadding: const EdgeInsets.all(16),
      actions: [
        SimpleButton(
          text: s.cancel,
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
        ),
        SimpleButton(
          text: confirmationText,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          backgroundColor: confirmationColor,
        ),
      ],
    );
  }
}
