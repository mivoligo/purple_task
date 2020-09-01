import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import './globals/hive_names.dart';
import './globals/strings/strings.dart';
import './db_models/category.dart';
import './db_models/task.dart';
import './ui/screens/home_screen.dart';
import 'ui/view_models/new_category_view_model.dart';
import './ui/view_models/category_view_model.dart';
import './ui/view_models/task_view_model.dart';

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
        ChangeNotifierProvider<NewCategoryViewModel>(
            create: (_) => NewCategoryViewModel()),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (_) => CategoryViewModel()),
        ChangeNotifierProvider<TaskViewModel>(create: (_) => TaskViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // remove focus from text field when clicking outside
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
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
      ),
    );
  }
}
