import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/shared_prefs/shared_prefs_provider.dart';
import 'package:purple_task/features/app_version/app_version_repository/app_version_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
AppVersionRepository appVersionRepository(Ref ref) =>
    AppVersionRepository(asyncPrefs: ref.read(sharedPreferencesAsyncProvider));
