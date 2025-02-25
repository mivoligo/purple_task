import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class TextChangeConfirmationDialog extends StatefulWidget {
  const TextChangeConfirmationDialog({
    required this.title,
    required this.confirmationButtonText,
    required this.initialText,
    required this.onConfirm,
    this.confirmationButtonColor = Colors.green,
    this.onCancel,
    super.key,
  });

  final String title;
  final String confirmationButtonText;
  final Color confirmationButtonColor;
  final String initialText;
  final void Function(String text)? onConfirm;
  final VoidCallback? onCancel;

  @override
  State<TextChangeConfirmationDialog> createState() =>
      _TextChangeConfirmationDialogState();
}

class _TextChangeConfirmationDialogState
    extends State<TextChangeConfirmationDialog> {
  final _textController = TextEditingController();

  late bool _hasText;

  void _updateTextField() {
    setState(() {
      _hasText = _textController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _hasText = widget.initialText.isNotEmpty;
    _textController
      ..text = widget.initialText
      ..addListener(_updateTextField);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      title: Text(widget.title),
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: CupertinoTextField(
          controller: _textController,
          autofocus: true,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          onSubmitted: (value) {
            widget.onConfirm?.call(value);
            Navigator.of(context).pop();
          },
        ),
      ),
      buttonPadding: const EdgeInsets.all(16),
      actions: [
        SimpleButton(
          text: s.cancel,
          onPressed: () {
            widget.onCancel?.call();
            Navigator.of(context).pop();
          },
        ),
        SimpleButton(
          text: widget.confirmationButtonText,
          onPressed: _hasText
              ? () {
                  final editedText = _textController.text.trim();
                  if (editedText != widget.initialText) {
                    widget.onConfirm?.call(editedText);
                  }
                  Navigator.of(context).pop();
                }
              : null,
          backgroundColor: widget.confirmationButtonColor,
        ),
      ],
    );
  }
}
