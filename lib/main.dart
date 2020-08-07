import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/ui/screens/home_mobile.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:to_do/ui/view_models/category_view_model.dart';

void main() async {
  Directory dir = await pathProvider.getApplicationSupportDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(CategoryAdapter());
  runApp(
    MultiProvider(
      providers: [
        Provider<Strings>(create: (_) => Strings()),
        ChangeNotifierProvider<NewCategory>(create: (_) => NewCategory()),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (_) => CategoryViewModel()),
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeMobile(),
    );
  }
}
