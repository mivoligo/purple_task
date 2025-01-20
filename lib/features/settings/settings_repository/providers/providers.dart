import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/features/settings/settings_repository/base_settings_repository.dart';
import 'package:purple_task/features/settings/settings_repository/shared_pref_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
BaseSettingsRepository settingsRepository(Ref ref) =>
    SharedPrefSettingsRepository(asyncPrefs: SharedPreferencesAsync());
