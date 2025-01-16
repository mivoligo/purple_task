import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/screens/main_screen/main_screen.dart';
import 'package:purple_task/core/ui/screens/welcome_screen.dart';
import 'package:purple_task/features/app_version/controllers/app_version_controller.dart';

class RedirectScreen extends ConsumerWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      appVersionProvider,
      (previous, next) {
        return switch (next) {
          AsyncData(:final value) =>
            Navigator.of(context).pushReplacement(_createRoute(value)),
          AsyncError() => print('jakby error'),
          _ => print('jakby nic'),
        };
      },
    );

    return Container();
  }

  Route<void> _createRoute(String? appVersion) {
    final target = switch (appVersion) {
      s.appVersion => const MainScreen(),
      _ => const WelcomeScreen(),
    };

    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => target,
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}
