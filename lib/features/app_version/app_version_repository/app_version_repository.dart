import 'package:purple_task/core/constants/hive_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppVersionRepository {
  AppVersionRepository({required this.asyncPrefs});

  final SharedPreferencesAsync asyncPrefs;

  Future<int?> getAppVersion() => asyncPrefs.getInt(appVersionKey);

  Future<void> setAppVersion() async {
    final currentVersion = await getAppVersion();

    if (currentVersion == null) {
      await asyncPrefs.setInt(appVersionKey, 1);
    } else {
      await asyncPrefs.setInt(appVersionKey, currentVersion + 1);
    }
  }
}
