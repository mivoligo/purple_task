import 'package:intl/intl.dart';

class TimeConversion {
  millisToDate(int input) {
    String pattern = 'y MMM d, HH:mm';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    return DateFormat(pattern).format(dateTime.toLocal());
  }

  String formatDateNow(String pattern) {
    DateTime dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
  }
}
