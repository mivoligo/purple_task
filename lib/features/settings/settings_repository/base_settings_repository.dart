import 'dart:async';

import 'package:purple_task/core/styles/themes.dart';

abstract class BaseSettingsRepository {
  Future<void> setTimeFormat({required String value});

  Future<String> getTimeFormat();

  Future<void> setDateFormat({required String value});

  Future<String> getDateFormat();

  Future<void> setDisplayTaskDoneTimePref({required bool value});

  Future<bool> getDisplayTaskDoneTimePref();

  Future<void> setUncategorizedViewPreference({required bool value});

  Future<bool> getUncategorizedViewPreference();

  Future<void> setTheme({required String value});

  Future<AppThemeMode> getTheme();

  Future<void> setLocale({required String value});

  Future<String?> getLocale();
}
