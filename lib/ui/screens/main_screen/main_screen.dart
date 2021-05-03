import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF303030),
              Colors.purple,
              Colors.purple,
            ]),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1000) {
            return const NarrowLayout();
          } else {
            return const WideLayout();
          }
        },
      ),
    );
  }
}
