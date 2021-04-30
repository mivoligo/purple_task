import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_task/globals/strings/strings.dart';

import '../../../helpers.dart';
import '../../../view_models/view_models.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<SettingsViewModel>(context);
    final _timeFormatList =
        Provider.of<SettingsViewModel>(context, listen: false).timeFormats;
    final timeConversion = TimeConversion();

    return Card(
      elevation: 1,
      child: PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            timeConversion.formatDateNow(_settings.getTimeFormat()),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        tooltip: changeFormat,
        onSelected: (dynamic item) =>
            _settings.setTimeFormat(_timeFormatList[item]),
        itemBuilder: (context) {
          var menuList = <PopupMenuEntry<Object>>[];
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
