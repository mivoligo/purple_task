import 'package:flutter/material.dart';

class AnimatedOpacityBuilder extends StatelessWidget {
  const AnimatedOpacityBuilder({
    Key? key,
    required this.animation,
    required this.content,
  }) : super(key: key);

  final Animation animation;
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
