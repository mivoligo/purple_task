import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/screens/home_mobile.dart';
import 'package:to_do/ui/screens/home_screen.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NewCategory>(create: (_) => NewCategory()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryList>(create: (_) => CategoryList()),
          Provider<Strings>(create: (_) => Strings()),
        ],
//        child: HomeScreen(),
        child: HomeMobile(),
      ),
    );
  }
}
