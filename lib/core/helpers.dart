import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:url_launcher/url_launcher.dart';

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

/// From the original code for `Color.value` in Flutter,
/// which was deprecated in v 3.27
///
/// A 32 bit value representing this color.
///
/// The bits are assigned as follows:
///
/// * Bits 24-31 are the alpha value.
/// * Bits 16-23 are the red value.
/// * Bits 8-15 are the green value.
/// * Bits 0-7 are the blue value.
extension ColorValueExtension on Color {
  int get intValue {
    return _floatToInt8(a) << 24 |
        _floatToInt8(r) << 16 |
        _floatToInt8(g) << 8 |
        _floatToInt8(b) << 0;
  }
}

int _floatToInt8(double x) {
  return (x * 255.0).round() & 0xff;
}

mixin TimeConverter {
  static String millisToDateAndTime(
    int input, {
    required String dateFormat,
    required String timeFormat,
  }) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(input);

    final date = DateFormat(dateFormat).format(dateTime);
    final time = DateFormat(timeFormat).format(dateTime);
    if (input.millisToDay().isToday || input.millisToDay().isYesterday) {
      return time;
    }
    return '$date, $time';
  }

  static String formatDateNow(String pattern) {
    final dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime);
  }

  static String formatDueDate(int? dateInMillis, String? dateFormat) {
    if (dateInMillis != null) {
      final now = DateTime.now();
      final yesterdayDate = DateTime(now.year, now.month, now.day - 1);
      final todayDate = DateTime(now.year, now.month, now.day);
      final tomorrowDate = DateTime(now.year, now.month, now.day + 1);
      final dueDateTime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
      final dueDate =
          DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);

      if (dueDate == todayDate) {
        return s.today;
      } else if (dueDate == tomorrowDate) {
        return s.tomorrow;
      } else if (dueDate == yesterdayDate) {
        return s.yesterday;
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
      throw Exception('Could not launch $url');
    }
  }
}
