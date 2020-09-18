import 'package:flutter/material.dart';
import '../../../globals/globals.dart';
import '../../../helpers.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatList = [
      'd MMMM y',
      'd MMM y',
      'd/M/y',
      'MMMM d y',
      'MMM d y',
      'M/d/y',
    ];
    TimeConversion timeConversion = TimeConversion();
    return PopupMenuButton(
      child: Text('current format'),
      tooltip: CHANGE_FORMAT,
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[0])),
            value: 0,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[1])),
            value: 1,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[2])),
            value: 2,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[3])),
            value: 3,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[4])),
            value: 4,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(formatList[5])),
            value: 5,
          ),
        );
        return list;
      },
    );
  }
}
