import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/strings/strings.dart' as s;
import 'widgets.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    this.content,
    required this.confirmationText,
    this.confirmationColor = Colors.green,
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  final String title;
  final Widget? content;
  final String confirmationText;
  final Color confirmationColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 8.0,
      ),
      title: Text(
        title,
        style: CustomStyle.textStyle24,
      ),
      content: content,
      buttonPadding: const EdgeInsets.all(16.0),
      actions: [
        SimpleButton(
          text: s.cancel,
          onPressed: () {
            if (onCancel != null) onCancel!();
            Navigator.of(context).pop();
          },
        ),
        SimpleButton(
          text: confirmationText,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          color: confirmationColor,
        ),
      ],
    );
  }
}
