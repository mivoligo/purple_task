import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app.dart';
import 'entities/entities.dart';
import 'globals/globals.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await path_provider.getApplicationSupportDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(CategoryEntityAdapter())
    ..registerAdapter(TaskEntityAdapter());
  // make sure hive boxes are opened before showing UI
  await Hive.openBox(settingsBox);
  await Hive.openBox<CategoryEntity>(categoryBox);
  await Hive.openBox<TaskEntity>(taskBox);

  // Set app window size
  AppWindowSize _appWindowSize = AppWindowSizePluginBased();
  _appWindowSize.setWindowSize();

  runApp(
    App(),
  );
}
