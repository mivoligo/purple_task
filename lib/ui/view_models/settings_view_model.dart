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
}
