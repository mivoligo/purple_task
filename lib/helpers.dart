import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/strings/strings.dart' as s;

class TimeConversion {
  static String millisToDateAndTime(
    int input, {
    required String dateFormat,
    required String timeFormat,
  }) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    final localDateTime = dateTime.toLocal();
    final date = DateFormat(dateFormat).format(localDateTime);
    final time = DateFormat(timeFormat).format(localDateTime);
    return '$date, $time';
  }

  static String formatDateNow(String pattern) {
    final dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
  }

  static String formatDueDate(int? dateInMillis, String? dateFormat) {
    if (dateInMillis != null) {
      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);
      final tomorrowDate = DateTime(now.year, now.month, now.day + 1);
      final dueDateTime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
      final dueDate =
          DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);
      if (dueDate == todayDate) {
        return s.today;
      } else if (dueDate == tomorrowDate) {
        return s.tomorrow;
      } else {
        return DateFormat(dateFormat).format(dueDate);
      }
    }
    return s.noDate;
  }
}

class UrlHelper {
  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
