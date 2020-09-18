import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeConversion {
  millisToDate(int input, {@required String dateFormat, String timeFormat}) {
    String pattern = '$dateFormat, $timeFormat';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    return DateFormat(pattern).format(dateTime.toLocal());
  }

  String formatDateNow(String pattern) {
    DateTime dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
  }
}
