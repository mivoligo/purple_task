import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/styles/providers/providers.dart';
import 'package:purple_task/core/styles/themes.dart';
import 'package:purple_task/core/ui/screens/redirect_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);
    return MaterialApp(
      title: s.appName,
      debugShowCheckedModeBanner: false,
      theme: PurpleAppTheme.lightTheme,
      darkTheme: PurpleAppTheme.darkTheme,
      themeMode: themeMode,
      home: const RedirectScreen(),
    );
  }
}
