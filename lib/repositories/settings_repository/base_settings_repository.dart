abstract class BaseSettingsRepository {
  void setTimeFormat({required String value});

  String getTimeFormat();

  void setDateFormat({required String value});

  String getDateFormat();

  void setDisplayTaskDoneTimePref({required bool value});

  bool getDisplayTaskDoneTimePref();

  void setUncategorizedViewPreference({required bool value});

  bool getUncategorizedViewPreference();
}
