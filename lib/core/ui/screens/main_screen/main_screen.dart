import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/animated_background.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/narrow_layout.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/wide_layout.dart';
import 'package:purple_task/features/app_version/controllers/app_version_controller.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(appVersionProvider.notifier).setAppVersion();
  }

  @override
  void dispose() {
    super.dispose();
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
