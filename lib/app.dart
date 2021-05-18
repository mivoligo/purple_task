import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          buttonBarTheme: const ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
          ),
          textTheme: TextTheme(
            // category name
            headline4: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
            ),
            // hello
            headline5: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
            ),
            // greetings info
            headline6: const TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
            // task name,
            // info with number of tasks left for category
            subtitle1: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            // dialog title when adding new category
            bodyText1: TextStyle(
              color: Colors.grey[700],
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
            // info text when adding new category
            bodyText2: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
            button: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}
