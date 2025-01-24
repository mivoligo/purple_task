import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.color,
    this.tooltip,
  });

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
