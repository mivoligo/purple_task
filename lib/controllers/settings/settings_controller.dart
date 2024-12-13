import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../providers/providers.dart';
import 'settings_state.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<SettingsState> build() async {
    final settingsRepository = ref.watch(settingsRepositoryProvider);

    final timeFormat = await settingsRepository.getTimeFormat();
    final dateFormat = await settingsRepository.getDateFormat();
    final showDoneTime = await settingsRepository.getDisplayTaskDoneTimePref();
    final isUncategorizedViewPreferred =
        await settingsRepository.getUncategorizedViewPreference();

    return SettingsState(
      timeFormat: timeFormat,
      dateFormat: dateFormat,
      showDoneTime: showDoneTime,
      isUncategorizedViewPreferred: isUncategorizedViewPreferred,
    );
  }

  Future<void> setTimeFormat({required String timeFormat}) async {
    ref.read(settingsRepositoryProvider).setTimeFormat(value: timeFormat);

    final updatedTimeFormat =
        await ref.read(settingsRepositoryProvider).getTimeFormat();

    await update(
      (currentState) => currentState.copyWith(timeFormat: updatedTimeFormat),
    );
  }

  Future<void> setDateFormat({required String dateFormat}) async {
    ref.read(settingsRepositoryProvider).setDateFormat(value: dateFormat);

    final updatedDateFormat =
        await ref.read(settingsRepositoryProvider).getDateFormat();

    await update(
      (currentState) => currentState.copyWith(dateFormat: updatedDateFormat),
    );
  }

  Future<void> setDisplayTaskDoneTimePref({required bool showDoneTime}) async {
    ref
        .read(settingsRepositoryProvider)
        .setDisplayTaskDoneTimePref(value: showDoneTime);

    final updatedDisplayTaskDoneTimePreference =
        await ref.read(settingsRepositoryProvider).getDisplayTaskDoneTimePref();

    await update(
      (currentState) => currentState.copyWith(
        showDoneTime: updatedDisplayTaskDoneTimePreference,
      ),
    );
  }

  Future<void> setUncategorizedViewPreference({required bool value}) async {
    ref
        .read(settingsRepositoryProvider)
        .setUncategorizedViewPreference(value: value);

    final updatedUncategorizedViewPreference = await ref
        .read(settingsRepositoryProvider)
        .getUncategorizedViewPreference();

    await update(
      (currentState) => currentState.copyWith(
        isUncategorizedViewPreferred: updatedUncategorizedViewPreference,
      ),
    );
  }
}
