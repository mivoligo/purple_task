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
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
