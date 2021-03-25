import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    required this.text,
    this.color = Colors.grey,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final String text;
  final Color color;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
