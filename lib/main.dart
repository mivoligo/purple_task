import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:purple_task/app.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';
import 'package:purple_task/features/todos/models/task_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();

  // TODO(m): Set app window size

  runApp(
    ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: const App(),
    ),
  );
}

Future<void> _initHive() async {
  final dir = await path_provider.getApplicationSupportDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(CategoryEntityAdapter())
    ..registerAdapter(TaskEntityAdapter());

  if (await Hive.boxExists(settingsBox)) {
    await Hive.openBox<dynamic>(settingsBox);
  }
  if (await Hive.boxExists(categoryBox)) {
    await Hive.openBox<CategoryEntity>(categoryBox);
  }
  if (await Hive.boxExists(taskBox)) {
    await Hive.openBox<TaskEntity>(taskBox);
  }
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
