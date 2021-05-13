import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/controllers.dart';
import '../../../../globals/globals.dart' as g;
import '../../../../globals/strings/strings.dart' as s;
import '../../../../helpers.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

              for (var i in g.dateFormats) {
                menuList.add(PopupMenuItem(
                  child: Text(TimeConversion.formatDateNow(i)),
                  value: g.dateFormats.indexOf(i),
                ));
              }

              return menuList;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                TimeConversion.formatDateNow(state.dateFormat),
                style: g.CustomStyle.textStyleTaskName
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
