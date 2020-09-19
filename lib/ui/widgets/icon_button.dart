import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomIconButton({
    Key key,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
