import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.color,
    this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Color? color;
  final String? tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? Colors.white,
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
