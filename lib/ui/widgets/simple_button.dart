import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  const SimpleButton({
    Key? key,
    required this.text,
    this.color = Colors.grey,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      focusNode: focusNode,
      color: color,
      onPressed: onPressed,
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
