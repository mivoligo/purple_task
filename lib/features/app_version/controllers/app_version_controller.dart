import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/providers/providers.dart';

part 'app_version_controller.g.dart';

@riverpod
class AppVersion extends _$AppVersion {
  @override
  Future<int?> build() async {
    final appVersionRepository = ref.watch(appVersionRepositoryProvider);

    return appVersionRepository.getAppVersion();
  }

  void setAppVersion() {
    ref.read(appVersionRepositoryProvider).setAppVersion();
  }
}