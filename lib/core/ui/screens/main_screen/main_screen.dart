import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/animated_background.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/narrow_layout/narrow_layout.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/wide_layout/wide_layout.dart';
import 'package:purple_task/features/app_version/controllers/app_version_controller.dart';
import 'package:purple_task/features/settings/models/app_window_size.dart';
import 'package:purple_task/features/settings/models/app_window_size_plugin_based.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with WidgetsBindingObserver {
  final AppWindowSize _appWindowSize = AppWindowSizePluginBased();
  Size? _windowSize =
      WidgetsBinding.instance.platformDispatcher.implicitView?.physicalSize;
  Size? _tempWindowSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(appVersionProvider.notifier).setAppVersion();
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
