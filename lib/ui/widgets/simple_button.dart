import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    required this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor = Colors.grey,
    this.foregroundColor = Colors.white,
    this.isOutlined = false,
    this.focusNode,
    super.key,
  });

  final String? text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    Widget child() {
      if (icon != null && text != null) {
        return Row(
          children: [
            icon!,
            const SizedBox(width: 4),
            Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        );
      }
      if (text != null) {
        return Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.normal),
        );
      }
      if (icon != null) {
        return icon!;
      }
      return const SizedBox(width: 16);
    }

    return FilledButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(40, 40),
        backgroundColor: isOutlined ? Colors.transparent : backgroundColor,
        foregroundColor: foregroundColor,
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: text != null ? 10 : 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          side: isOutlined
              ? BorderSide(width: 1, color: foregroundColor)
              : BorderSide.none,
        ),
      ),
      child: child(),
    );
  }
}
