import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app.dart';
import 'constants/constants.dart';
import 'entities/entities.dart';

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
  await Hive.openBox<List<String>>(categoriesListOrderBox);
  await Hive.openBox<Map<dynamic, dynamic>>(tasksListOrderBox);

  // todo: Set app window size

  runApp(
    ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: App(),
    ),
  );
}

class MyObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    // print('Provider $provider was initialized with $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    // print('Provider $provider was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // print('Provider $provider updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    print('Provider $provider threw $error at $stackTrace');
  }
}
