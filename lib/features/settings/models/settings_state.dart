import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.timeFormat,
    required this.dateFormat,
    required this.showDoneTime,
    required this.isUncategorizedViewPreferred,
  });

  final String timeFormat;
  final String dateFormat;
  final bool showDoneTime;
  final bool isUncategorizedViewPreferred;

  SettingsState copyWith({
    String? timeFormat,
    String? dateFormat,
    bool? showDoneTime,
    bool? isUncategorizedViewPreferred,
  }) {
    return SettingsState(
      timeFormat: timeFormat ?? this.timeFormat,
      dateFormat: dateFormat ?? this.dateFormat,
      showDoneTime: showDoneTime ?? this.showDoneTime,
      isUncategorizedViewPreferred:
          isUncategorizedViewPreferred ?? this.isUncategorizedViewPreferred,
    );
  }

  @override
  List<Object?> get props =>
      [timeFormat, dateFormat, showDoneTime, isUncategorizedViewPreferred];
}
