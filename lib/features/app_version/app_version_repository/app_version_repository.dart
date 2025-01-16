import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/constants/strings/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppVersionRepository {
  AppVersionRepository({required SharedPreferencesAsync asyncPrefs})
      : _asyncPrefs = asyncPrefs;

  final SharedPreferencesAsync _asyncPrefs;

  Future<String?> getAppVersion() => _asyncPrefs.getString(appVersionKey);

  Future<void> setAppVersion() async {
    final currentVersion = await getAppVersion();

    if (currentVersion != appVersion) {
      await _asyncPrefs.setString(appVersionKey, appVersion);
    }
  }
}
