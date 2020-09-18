import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeConversion {
  millisToDateAndTime(
    int input, {
    @required String dateFormat,
    @required String timeFormat,
  }) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    DateTime localDateTime = dateTime.toLocal();
    String date = DateFormat(dateFormat).format(localDateTime);
    String time = DateFormat(timeFormat).format(localDateTime);
    return '$date, $time';
  }

  String formatDateNow(String pattern) {
    DateTime dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
  }
}
