import 'package:flutter/material.dart';
import '../../../globals/globals.dart';
import '../../ui.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    this.content,
    required this.confirmationText,
    this.confirmationColor = Colors.green,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  final String title;
  final Widget? content;
  final String confirmationText;
  final Color confirmationColor;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      content: content,
      buttonPadding: EdgeInsets.all(16.0),
      actions: [
        SimpleButton(
          text: cancel,
          onPressed: onCancel,
        ),
        SimpleButton(
          text: confirmationText,
          onPressed: onConfirm,
          color: confirmationColor,
        )
      ],
    );
  }
}
