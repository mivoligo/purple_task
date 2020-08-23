import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/screens/home_mobile.dart';
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeMobile(),
    );
  }
}
