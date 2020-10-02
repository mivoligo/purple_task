import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers.dart';
import '../../ui.dart';
import '../../../globals/globals.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<SettingsViewModel>(context);
    final _timeFormatList =
        Provider.of<SettingsViewModel>(context, listen: false).timeFormats;
    TimeConversion timeConversion = TimeConversion();

    return Card(
      elevation: 1,
      child: PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            timeConversion.formatDateNow(_settings.getTimeFormat()),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        tooltip: CHANGE_FORMAT,
        onSelected: (item) => _settings.setTimeFormat(_timeFormatList[item]),
        itemBuilder: (context) {
          var menuList = List<PopupMenuEntry<Object>>();
          menuList.add(
            PopupMenuItem(
              child: Text(timeConversion.formatDateNow(_timeFormatList[0])),
              value: 0,
            ),
          );
          menuList.add(
            PopupMenuItem(
              child: Text(timeConversion.formatDateNow(_timeFormatList[1])),
              value: 1,
            ),
          );
          return menuList;
        },
      ),
    );
  }
}
