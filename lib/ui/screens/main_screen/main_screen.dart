import 'package:flutter/material.dart';

import '../../../models/models.dart';
import 'widgets/animated_background.dart';
import 'widgets/narrow_layout/narrow_layout.dart';
import 'widgets/wide_layout/wide_layout.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

// ignore: prefer_mixin
class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final AppWindowSize _appWindowSize = AppWindowSizePluginBased();
  Size? _windowSize =
      WidgetsBinding.instance.platformDispatcher.implicitView?.physicalSize;
  Size? _tempWindowSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Used to save app window size on resize
  @override
  void didChangeMetrics() {
    _tempWindowSize =
        WidgetsBinding.instance.platformDispatcher.implicitView?.physicalSize;
    if (_windowSize != _tempWindowSize) {
      _windowSize = _tempWindowSize;
      _appWindowSize.saveWindowSize(_windowSize!.width, _windowSize!.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 700) {
                return const NarrowLayout();
              }
              return const WideLayout();
            },
          ),
        ),
      ),
    );
  }
}
