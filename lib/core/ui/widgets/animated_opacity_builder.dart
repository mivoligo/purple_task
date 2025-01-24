import 'package:flutter/material.dart';

class AnimatedOpacityBuilder extends StatelessWidget {
  const AnimatedOpacityBuilder({
    required this.animation,
    required this.content,
    super.key,
  });

  final Animation<double> animation;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: content,
    );
  }
}
