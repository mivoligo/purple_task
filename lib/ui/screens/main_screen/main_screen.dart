import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';
import 'widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

// ignore: prefer_mixin
class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final AppWindowSize _appWindowSize = AppWindowSizePluginBased();
  Size? _windowSize = WidgetsBinding.instance!.window.physicalSize;
  Size? _tempWindowSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // Used to save app window size on resize
  @override
  void didChangeMetrics() {
    _tempWindowSize = WidgetsBinding.instance!.window.physicalSize;
    if (_windowSize != _tempWindowSize) {
      _windowSize = _tempWindowSize;
      _appWindowSize.saveWindowSize(_windowSize!.width, _windowSize!.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(
          builder: (context, watch, _) {
            final backgroundColor = watch(backgroundColorProvider);

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
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 1000) {
              return const NarrowLayout();
            } else {
              return const WideLayout();
            }
          },
        ),
      ],
    );
  }
}
