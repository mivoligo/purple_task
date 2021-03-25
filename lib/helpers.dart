import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeConversion {
  millisToDateAndTime(
    int input, {
    required String? dateFormat,
    required String? timeFormat,
  }) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    DateTime localDateTime = dateTime.toLocal();
    String date = DateFormat(dateFormat).format(localDateTime);
    String time = DateFormat(timeFormat).format(localDateTime);
    return '$date, $time';
  }

  String formatDateNow(String? pattern) {
    DateTime dateTime = DateTime.now();
    return DateFormat(pattern).format(dateTime.toLocal());
  }
}

class UrlHelper {
  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
