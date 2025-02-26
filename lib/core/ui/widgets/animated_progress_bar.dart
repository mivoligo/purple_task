import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    required this.color,
    required this.value,
    super.key,
  });

  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      height: 4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.constrainWidth();
          return Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: value * width,
                height: 4,
                color: color,
              ),
            ],
          );
        },
      ),
    );
  }
}
