import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/ui/widgets/simple_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmationText;
  final Color confirmationColor;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    Key key,
    @required this.title,
    this.content,
    @required this.confirmationText,
    @required this.confirmationColor,
    @required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      content: content,
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        SimpleButton(
          text: CANCEL,
          onPressed: Navigator.of(context).pop,
        ),
        SimpleButton(
          text: confirmationText,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          color: confirmationColor,
        )
      ],
    );
  }
}
