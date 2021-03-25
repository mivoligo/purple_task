import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../globals/globals.dart';

class SettingsViewModel with ChangeNotifier {
  final List<String> _timeFormats = [
    'Hm', // 24h
    'jm', // a.m. p.m.
  ];

  List<String> get timeFormats => _timeFormats;

  setTimeFormat(String value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(TIME_FORMAT_KEY, value);
    notifyListeners();
  }

  getTimeFormat() {
    final box = Hive.box(SETTINGS_BOX);
    String? timeFormat = box.get(TIME_FORMAT_KEY, defaultValue: 'Hm');
    return timeFormat;
  }

  final List<String> _dateFormats = [
    'd MMMM y', // 13 August 1970
    'd MMM y', // 13 Aug 1970
    'd/M/y', // 13/8/1970
    'MMMM d y', // August 13 1970
    'MMM d y', // Aug 13 1970
    'M/d/y', // 8/13/1970
  ];

  List<String> get dateFormats => _dateFormats;

  setDateFormat(String value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(DATE_FORMAT_KEY, value);
    notifyListeners();
  }

  getDateFormat() {
    final box = Hive.box(SETTINGS_BOX);
    String? dateFormat = box.get(DATE_FORMAT_KEY, defaultValue: 'd MMM y');
    return dateFormat;
  }

  setDisplayTaskDoneTimePref(bool value) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(DISPLAY_TASK_DONE_TIME_PREF_KEY, value);
    notifyListeners();
  }

  getDisplayTaskDOneTimePref() {
    final box = Hive.box(SETTINGS_BOX);
    bool? pref = box.get(DISPLAY_TASK_DONE_TIME_PREF_KEY, defaultValue: true);
    return pref;
  }
}
