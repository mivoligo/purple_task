
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/hive_names.dart';
import '../migrator.dart';

part 'providers.g.dart';

@riverpod
SettingsMigrator settingsMigrator(Ref ref) => SettingsMigrator(
  asyncPrefs: SharedPreferencesAsync(),
  settingsBox: Hive.box(settingsBox),
);
