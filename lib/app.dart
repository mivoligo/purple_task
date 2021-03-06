import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/constants.dart';

import 'constants/strings/strings.dart' as s;
import 'ui/screens/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: s.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xffe83f6f),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFFE83F6F),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          buttonBarTheme: const ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
          ),
          textTheme: const TextTheme(
            button: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            ),
          ),
          tooltipTheme: TooltipThemeData(
            textStyle:
                CustomStyle.textStyleLabelSmall.copyWith(color: Colors.white),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}
