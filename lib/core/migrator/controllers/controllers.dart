import 'package:purple_task/core/hive_legacy/providers/providers.dart';
import 'package:purple_task/core/migrator/models/migration_state.dart';
import 'package:purple_task/core/migrator/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controllers.g.dart';

@riverpod
class MigrationStateController extends _$MigrationStateController {
  @override
  MigrationState build() =>
      const MigrationState(migrationStatus: MigrationStatus.idle);

  Future<void> migrateHive() async {
    state = state.copyWith(migrationStatus: MigrationStatus.pending);
    try {
      final hasSettingBox = await ref.read(hasSettingsHiveBoxProvider.future);

      if (hasSettingBox) {
        await ref
            .read(settingsMigratorProvider)
            .migrateSettingsFromHiveToSharedPreferences();
      }

      final hasCategoryBox = await ref.read(hasCategoryHiveBoxProvider.future);

      if (hasCategoryBox) {
        await ref
            .read(categoriesMigratorProvider)
            .migrateCategoriesFromHiveToDrift();
      }

      final hasTaskBox = await ref.read(hasTaskHiveBoxProvider.future);

      if (hasTaskBox) {
        await ref.read(tasksMigratorProvider).migrateTasksFromHiveToDrift();
      }

      state = state.copyWith(migrationStatus: MigrationStatus.success);
    } on Exception catch (e) {
      state = state.copyWith(
        migrationStatus: MigrationStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
