import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/strings/strings.dart' as s;
import '../../../../helpers.dart';
import '../../../../providers/providers.dart';

class DateFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(settingsControllerProvider);
        final controller = ref.watch(settingsControllerProvider.notifier);
        return Card(
          elevation: 1,
          child: PopupMenuButton(
            tooltip: s.changeFormat,
            onSelected: (item) => controller.setDateFormat(
              dateFormat: item as String,
            ),
            itemBuilder: (context) {
              var menuList = <PopupMenuEntry<String>>[];

              for (var format in dateFormats) {
                menuList.add(
                  PopupMenuItem(
                    child: Text(
                      TimeConversion.formatDateNow(format),
                      style: state.dateFormat == format
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                TimeConversion.formatDateNow(state.dateFormat),
                style: CustomStyle.textStyleTaskName
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
