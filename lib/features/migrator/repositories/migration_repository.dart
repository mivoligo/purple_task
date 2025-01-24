import 'package:purple_task/core/constants/key_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MigrationRepository {
  MigrationRepository({required SharedPreferencesAsync asyncPrefs})
      : _asyncPrefs = asyncPrefs;

  final SharedPreferencesAsync _asyncPrefs;

  Future<bool> migratedFromHive() async {
    final migrated = await _asyncPrefs.getBool(migratedFromHiveKey);
    return migrated ?? false;
  }

  Future<void> markAsMigratedFromHive() async {
    await _asyncPrefs.setBool(migratedFromHiveKey, true);
  }
}
