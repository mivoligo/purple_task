import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/todos/controllers/providers/providers.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final backgroundColor = ref.watch(appBackgroundColorProvider);

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
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
