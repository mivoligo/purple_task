import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/globals.dart' as g;
import '../../../../globals/strings/strings.dart' as s;
import '../../../../helpers.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeConversion = TimeConversion();

    return Consumer(
      builder: (context, watch, child) {
        final state = watch(settingsControllerProvider);
        final controller = watch(settingsControllerProvider.notifier);
        return Card(
          elevation: 1,
          child: PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timeConversion.formatDateNow(state.timeFormat),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            tooltip: s.changeFormat,
            onSelected: (item) => controller.setTimeFormat(
              timeFormat: g.timeFormats[item as int],
            ),
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<Object>>[];
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.timeFormats[0])),
                  value: 0,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.timeFormats[1])),
                  value: 1,
                ),
              );
              return menuList;
            },
          ),
        );
      },
    );
  }
}
