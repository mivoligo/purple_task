import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool autofocus;

  const SimpleButton({
    Key key,
    @required this.text,
    this.color = Colors.grey,
    @required this.onPressed,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
