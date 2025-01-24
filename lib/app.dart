import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/screens/redirect_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: s.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xffe83f6f),
          tooltipTheme: TooltipThemeData(
            textStyle:
                CustomStyle.textStyleLabelSmall.copyWith(color: Colors.white),
            waitDuration: const Duration(milliseconds: 600),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const RedirectScreen(),
      ),
    );
  }
}
