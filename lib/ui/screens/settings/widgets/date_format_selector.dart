import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/globals.dart' as g;
import '../../../../globals/strings/strings.dart' as s;
import '../../../../helpers.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeConversion = TimeConversion();
    return Consumer(
      builder: (context, watch, _) {
        final state = watch(settingsControllerProvider);
        final controller = watch(settingsControllerProvider.notifier);
        return Card(
          elevation: 1,
          child: PopupMenuButton(
            tooltip: s.changeFormat,
            onSelected: (item) => controller.setDateFormat(
              dateFormat: g.dateFormats[item as int],
            ),
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<Object>>[];
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[0])),
                  value: 0,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[1])),
                  value: 1,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[2])),
                  value: 2,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[3])),
                  value: 3,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[4])),
                  value: 4,
                ),
              );
              menuList.add(
                PopupMenuItem(
                  child: Text(timeConversion.formatDateNow(g.dateFormats[5])),
                  value: 5,
                ),
              );
              return menuList;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timeConversion.formatDateNow(state.dateFormat),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
