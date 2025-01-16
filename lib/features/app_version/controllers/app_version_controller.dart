import 'package:purple_task/features/settings/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_controller.g.dart';

@riverpod
class AppVersion extends _$AppVersion {
  @override
  Future<String?> build() async {
    final appVersionRepository = ref.watch(appVersionRepositoryProvider);

    return appVersionRepository.getAppVersion();
  }

  Future<void> setAppVersion() async =>
      ref.read(appVersionRepositoryProvider).setAppVersion();
}
