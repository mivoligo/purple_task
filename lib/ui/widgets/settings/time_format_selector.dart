import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui.dart';
import '../../../globals/globals.dart';

class TimeFormatSelector extends StatefulWidget {
  @override
  _TimeFormatSelectorState createState() => _TimeFormatSelectorState();
}

class _TimeFormatSelectorState extends State<TimeFormatSelector> {
  SettingsViewModel _settings;

  @override
  Widget build(BuildContext context) {
    _settings = Provider.of<SettingsViewModel>(context);
    return PopupMenuButton(
      child: Text(
        _settings.getTimeFormat(),
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      tooltip: CHANGE_FORMAT,
      onSelected: (item) => onItemSelected(item),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
            child: Text(H12),
            value: 0,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text(H24),
            value: 1,
          ),
        );
        return list;
      },
    );
  }

  void onItemSelected(item) {
    switch (item) {
      case 0:
        _settings.setTimeFormat(H12);
        break;
      case 1:
        _settings.setTimeFormat(H24);
        break;
    }
  }
}
