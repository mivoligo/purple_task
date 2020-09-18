import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/ui/ui.dart';
import '../../../globals/globals.dart';
import '../../../helpers.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<SettingsViewModel>(context);
    final _formatList =
        Provider.of<SettingsViewModel>(context, listen: false).dateFormats;
    TimeConversion timeConversion = TimeConversion();
    return PopupMenuButton(
      child: Text(
        timeConversion.formatDateNow(_settings.getDateFormat()),
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      tooltip: CHANGE_FORMAT,
      onSelected: (item) => _settings.setDateFormat(_formatList[item]),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[0])),
            value: 0,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[1])),
            value: 1,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[2])),
            value: 2,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[3])),
            value: 3,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[4])),
            value: 4,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(timeConversion.formatDateNow(_formatList[5])),
            value: 5,
          ),
        );
        return list;
      },
    );
  }
}
