import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../globals/globals.dart';

class SettingsViewModel extends ChangeNotifier {
  final List<String> _timeFormats = [
    'Hm', // 24h
    'jm', // a.m. p.m.
  ];

  List<String> get timeFormats => _timeFormats;

  void setTimeFormat(String value) {
    final box = Hive.box(settingsBox);
    box.put(timeFormatKey, value);
    notifyListeners();
  }

  String getTimeFormat() {
    final box = Hive.box(settingsBox);
    String timeFormat = box.get(timeFormatKey, defaultValue: 'Hm');
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

  void setDateFormat(String value) {
    final box = Hive.box(settingsBox);
    box.put(dateFormatKey, value);
    notifyListeners();
  }

  String getDateFormat() {
    final box = Hive.box(settingsBox);
    String dateFormat = box.get(dateFormatKey, defaultValue: 'd MMM y');
    return dateFormat;
  }

  void setDisplayTaskDoneTimePref({required bool value}) {
    final box = Hive.box(settingsBox);
    box.put(displayTaskDonePrefKey, value);
    notifyListeners();
  }

  bool getDisplayTaskDOneTimePref() {
    final box = Hive.box(settingsBox);
    bool pref = box.get(displayTaskDonePrefKey, defaultValue: true);
    return pref;
  }
}
