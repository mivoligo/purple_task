import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../repositories.dart';

class SharedPrefSettingsRepository implements BaseSettingsRepository {
  SharedPrefSettingsRepository({required this.asyncPrefs});

  final SharedPreferencesAsync asyncPrefs;

  @override
  void setDateFormat({required String value}) async {
    await asyncPrefs.setString(dateFormatKey, value);
  }

  @override
  Future<String> getDateFormat() async {
    return await asyncPrefs.getString(dateFormatKey) ?? 'd MMM y';
  }

  @override
  void setTimeFormat({required String value}) async {
    await asyncPrefs.setString(timeFormatKey, value);
  }

  @override
  Future<String> getTimeFormat() async {
    return await asyncPrefs.getString(timeFormatKey) ?? 'Hm';
  }

  @override
  void setDisplayTaskDoneTimePref({required bool value}) async {
    await asyncPrefs.setBool(displayTaskDonePrefKey, value);
  }

  @override
  Future<bool> getDisplayTaskDoneTimePref() async {
    return await asyncPrefs.getBool(displayTaskDonePrefKey) ?? false;
  }

  @override
  void setUncategorizedViewPreference({required bool value}) async {
    await asyncPrefs.setBool(uncategorizedViewPreferenceKey, value);
  }

  @override
  Future<bool> getUncategorizedViewPreference() async {
    return await asyncPrefs.getBool(uncategorizedViewPreferenceKey) ?? true;
  }
}
