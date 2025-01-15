import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<bool> hasAnyHiveBox(Ref ref) async {
  final hasSettingsBox = await Hive.boxExists(settingsBox);
  final hasCategoryBox = await Hive.boxExists(categoryBox);
  final hasTaskBox = await Hive.boxExists(taskBox);
  return hasSettingsBox || hasCategoryBox || hasTaskBox;
}

@riverpod
Future<bool> hasSettingsHiveBox(Ref ref) async => Hive.boxExists(settingsBox);

@riverpod
Future<bool> hasCategoryHiveBox(Ref ref) async => Hive.boxExists(categoryBox);

@riverpod
Future<bool> hasTaskHiveBox(Ref ref) async => Hive.boxExists(taskBox);
