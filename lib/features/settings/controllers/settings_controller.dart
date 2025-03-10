import 'package:purple_task/features/settings/models/settings_state.dart';
import 'package:purple_task/features/settings/settings_repository/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final theme = await settingsRepository.getTheme();
    final locale = await settingsRepository.getLocale();

    return SettingsState(
      timeFormat: timeFormat,
      dateFormat: dateFormat,
      showDoneTime: showDoneTime,
      isUncategorizedViewPreferred: isUncategorizedViewPreferred,
      theme: theme,
      locale: locale,
    );
  }

  Future<void> setTimeFormat({required String timeFormat}) async {
    await ref.read(settingsRepositoryProvider).setTimeFormat(value: timeFormat);

    final updatedTimeFormat =
        await ref.read(settingsRepositoryProvider).getTimeFormat();

    await update(
      (currentState) => currentState.copyWith(timeFormat: updatedTimeFormat),
    );
  }

  Future<void> setDateFormat({required String dateFormat}) async {
    await ref.read(settingsRepositoryProvider).setDateFormat(value: dateFormat);

    final updatedDateFormat =
        await ref.read(settingsRepositoryProvider).getDateFormat();

    await update(
      (currentState) => currentState.copyWith(dateFormat: updatedDateFormat),
    );
  }

  Future<void> setDisplayTaskDoneTimePref({required bool showDoneTime}) async {
    await ref
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
    await ref
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

  Future<void> setTheme({required String value}) async {
    await ref.read(settingsRepositoryProvider).setTheme(value: value);

    final updatedTheme = await ref.read(settingsRepositoryProvider).getTheme();

    await update(
      (currentState) => currentState.copyWith(theme: updatedTheme),
    );
  }

  Future<void> setLocale({required String value}) async {
    await ref.read(settingsRepositoryProvider).setLocale(value: value);

    final updatedLocale =
        await ref.read(settingsRepositoryProvider).getLocale();

    await update(
      (currentState) => currentState.copyWith(locale: updatedLocale),
    );
  }
}
