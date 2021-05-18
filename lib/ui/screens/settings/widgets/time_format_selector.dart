import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../controllers/controllers.dart';
import '../../../../helpers.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final state = watch(settingsControllerProvider);
        final controller = watch(settingsControllerProvider.notifier);
        return Card(
          elevation: 1,
          child: PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                TimeConversion.formatDateNow(state.timeFormat),
                style: CustomStyle.textStyleTaskName
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            tooltip: s.changeFormat,
            onSelected: (item) => controller.setTimeFormat(
              timeFormat: item as String,
            ),
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<String>>[];

              for (var format in timeFormats) {
                menuList.add(
                  PopupMenuItem(
                    child: Text(
                      TimeConversion.formatDateNow(format),
                      style: state.timeFormat == format
                          ? CustomStyle.textStyleTaskName
                              .copyWith(color: Theme.of(context).primaryColor)
                          : CustomStyle.textStyleTaskName,
                    ),
                    value: format,
                  ),
                );
              }

              return menuList;
            },
          ),
        );
      },
    );
  }
}
