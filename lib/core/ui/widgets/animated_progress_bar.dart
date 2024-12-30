import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    Key? key,
    required this.color,
    required this.value,
  }) : super(key: key);

  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: 4.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final _width = constraints.constrainWidth();
          return Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: value * _width,
                height: 4.0,
                color: color,
              ),
            ],
          );
        },
      ),
    );
  }
}
