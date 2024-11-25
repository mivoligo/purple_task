import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/strings/strings.dart' as s;

extension DateTimeExtensions on DateTime {
  bool get isBeforeYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return isBefore(yesterday);
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday == this;
  }

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today == this;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow == this;
  }

  bool get isAfterTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return isAfter(tomorrow);
  }
}

extension IntExtensions on int {
  DateTime millisToDay() {
    final timeInMillis = DateTime.fromMillisecondsSinceEpoch(this);
    return DateTime(timeInMillis.year, timeInMillis.month, timeInMillis.day);
  }
}

mixin TimeConverter {
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
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
