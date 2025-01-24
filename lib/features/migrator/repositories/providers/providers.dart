import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/shared_prefs/shared_prefs_provider.dart';
import 'package:purple_task/features/migrator/repositories/migration_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
MigrationRepository migrationRepository(Ref ref) =>
    MigrationRepository(asyncPrefs: ref.read(sharedPreferencesAsyncProvider));
