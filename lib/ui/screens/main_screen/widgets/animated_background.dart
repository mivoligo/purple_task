import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/providers.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final backgroundColor = watch(backgroundColorNarrowLayoutProvider);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF303030),
                  backgroundColor,
                  backgroundColor,
                ]),
          ),
        );
      },
    );
  }
}
