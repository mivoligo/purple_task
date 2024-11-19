import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../providers/providers.dart';
import 'settings_state.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    final settingsRepository = ref.watch(settingsRepositoryProvider);

    return SettingsState(
      timeFormat: settingsRepository.getTimeFormat(),
      dateFormat: settingsRepository.getDateFormat(),
      showDoneTime: settingsRepository.getDisplayTaskDoneTimePref(),
    );
  }

  void setTimeFormat({required String timeFormat}) {
    state = state.copyWith(timeFormat: timeFormat);
    ref.read(settingsRepositoryProvider).setTimeFormat(value: timeFormat);
  }

  void setDateFormat({required String dateFormat}) {
    state = state.copyWith(dateFormat: dateFormat);
    ref.read(settingsRepositoryProvider).setDateFormat(value: dateFormat);
  }

  void setDisplayTaskDoneTimePref({required bool showDoneTime}) {
    state = state.copyWith(showDoneTime: showDoneTime);
    ref
        .read(settingsRepositoryProvider)
        .setDisplayTaskDoneTimePref(value: showDoneTime);
  }
}
