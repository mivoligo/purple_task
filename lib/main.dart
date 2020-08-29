import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/screens/home_screen.dart';
import 'package:to_do/models/new_category.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory dir = await pathProvider.getApplicationSupportDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(TaskAdapter());
  // make sure hive boxes are opened before showing UI
  await Hive.openBox<Category>(CATEGORY_BOX);
  await Hive.openBox<Task>(TASK_BOX);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewCategory>(create: (_) => NewCategory()),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (_) => CategoryViewModel()),
        ChangeNotifierProvider<TaskViewModel>(create: (_) => TaskViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffe83f6f),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        buttonBarTheme: ButtonBarThemeData(
          alignment: MainAxisAlignment.spaceBetween,
        ),
        textTheme: TextTheme(
            // category name
            headline4: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
            ),
            // hello
            headline5: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
            ),
            // greetings info
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
            // task name,
            // info with number of tasks left for category
            subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            // task name when done
            subtitle2: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              decoration: TextDecoration.lineThrough,
            ),
            // dialog title when adding new category
            bodyText1: TextStyle(
              color: Colors.grey[700],
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
            // info text when adding new category
            bodyText2: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
            button: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
