import 'dart:async';

abstract class BaseSettingsRepository {
  void setTimeFormat({required String value});

  Future<String> getTimeFormat();

  void setDateFormat({required String value});

  Future<String> getDateFormat();

  void setDisplayTaskDoneTimePref({required bool value});

  Future<bool> getDisplayTaskDoneTimePref();

  void setUncategorizedViewPreference({required bool value});

  Future<bool> getUncategorizedViewPreference();
}
