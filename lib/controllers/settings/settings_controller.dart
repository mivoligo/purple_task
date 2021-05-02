import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/repositories.dart';
import 'settings_state.dart';

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
      baseSettingsRepository: ref.watch(settingsRepositoryProvider));
});

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController({
    required BaseSettingsRepository baseSettingsRepository,
  })  : _settingsRepository = baseSettingsRepository,
        super(
          SettingsState(
            timeFormat: baseSettingsRepository.getTimeFormat(),
            dateFormat: baseSettingsRepository.getDateFormat(),
            showDoneTime: baseSettingsRepository.getDisplayTaskDoneTimePref(),
          ),
        );

  final BaseSettingsRepository _settingsRepository;

  void setTimeFormat({required String timeFormat}) {
    state = state.copyWith(timeFormat: timeFormat);
    _settingsRepository.setTimeFormat(value: timeFormat);
  }

  void setDateFormat({required String dateFormat}) {
    state = state.copyWith(dateFormat: dateFormat);
    _settingsRepository.setDateFormat(value: dateFormat);
  }

  void setDisplayTaskDoneTimePref({required bool showDoneTime}) {
    state = state.copyWith(showDoneTime: showDoneTime);
    _settingsRepository.setDisplayTaskDoneTimePref(value: showDoneTime);
  }
}
