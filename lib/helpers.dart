import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeConversion {
  String millisToDateAndTime(
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

  String formatDateNow(String pattern) {
    final dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
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
