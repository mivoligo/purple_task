import 'dart:async';

import 'package:purple_task/core/styles/themes.dart';

abstract class BaseSettingsRepository {
  void setTimeFormat({required String value});

  Future<String> getTimeFormat();

  void setDateFormat({required String value});

  Future<String> getDateFormat();

  void setDisplayTaskDoneTimePref({required bool value});

  Future<bool> getDisplayTaskDoneTimePref();

  void setUncategorizedViewPreference({required bool value});

  Future<bool> getUncategorizedViewPreference();

  void setTheme({required String value});

  Future<AppThemeMode> getTheme();
}
