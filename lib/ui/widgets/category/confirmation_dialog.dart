import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../globals/strings/strings.dart';
import '../simple_button.dart';

class ConfirmationDialog extends StatefulWidget {
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
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    print('rebuilding dialog');
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline4,
      ),
      content: widget.content,
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        SimpleButton(
          text: CANCEL,
          onPressed: Navigator.of(context).pop,
        ),
        SimpleButton(
          text: widget.confirmationText,
          onPressed: () {
            widget.onConfirm();
            Navigator.of(context).pop();
          },
          color: widget.confirmationColor,
        )
      ],
    );
  }
}
