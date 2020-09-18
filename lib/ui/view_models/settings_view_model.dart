import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../globals/globals.dart';

class SettingsViewModel with ChangeNotifier {
  setTimeFormat(String value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(TIME_FORMAT_KEY, value);
    notifyListeners();
  }

  getTimeFormat() {
    final box = Hive.box(SETTINGS_BOX);
    String timeFormat = box.get(TIME_FORMAT_KEY, defaultValue: H24);
    return timeFormat;
  }

  final List<String> _dateFormats = [
    'd MMMM y',
    'd MMM y',
    'd/M/y',
    'MMMM d y',
    'MMM d y',
    'M/d/y',
  ];

  List<String> get dateFormats => _dateFormats;

  setDateFormat(String value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(DATE_FORMAT_KEY, value);
    notifyListeners();
  }

  getDateFormat() {
    final box = Hive.box(SETTINGS_BOX);
    String dateFormat = box.get(DATE_FORMAT_KEY, defaultValue: 'd MMM y');
    return dateFormat;
  }

  setDisplayTaskDoneTimePref(bool value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(DISPLAY_TASK_DONE_TIME_PREF_KEY, value);
    notifyListeners();
  }

  getDisplayTaskDOneTimePref() {
    final box = Hive.box(SETTINGS_BOX);
    bool pref = box.get(DISPLAY_TASK_DONE_TIME_PREF_KEY, defaultValue: true);
    return pref;
  }
}
