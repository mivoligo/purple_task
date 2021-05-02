import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  SettingsState({
    required this.timeFormat,
    required this.dateFormat,
    required this.showDoneTime,
  });

  final String timeFormat;
  final String dateFormat;
  final bool showDoneTime;

  SettingsState copyWith({
    String? timeFormat,
    String? dateFormat,
    bool? showDoneTime,
  }) {
    return SettingsState(
      timeFormat: timeFormat ?? this.timeFormat,
      dateFormat: dateFormat ?? this.dateFormat,
      showDoneTime: showDoneTime ?? this.showDoneTime,
    );
  }

  @override
  List<Object?> get props => [timeFormat, dateFormat, showDoneTime];
}
