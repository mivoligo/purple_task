import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../controllers/controllers.dart';
import '../../../../helpers.dart';
import '../../../widgets/widgets.dart';

class TimeFormatSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final settingsState = ref.watch(settingsNotifierProvider);
        final controller = ref.watch(settingsNotifierProvider.notifier);
        return MenuAnchor(
          menuChildren: [
            ...timeFormats.map(
              (timeFormat) => MenuItemButton(
                onPressed: () {
                  controller.setTimeFormat(
                    timeFormat: timeFormat,
                  );
                },
                child: Text(
                  TimeConverter.formatDateNow(timeFormat),
                  style: settingsState.value?.timeFormat == timeFormat
                      ? CustomStyle.textStyleTaskName
                          .copyWith(color: Theme.of(context).primaryColor)
                      : CustomStyle.textStyleTaskName,
                ),
              ),
            ),
          ],
          builder: (context, controller, child) {
            return SimpleButton(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.white,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              text: TimeConverter.formatDateNow(
                settingsState.value?.timeFormat ?? 'Hm',
              ),
            );
          },
        );
      },
    );
  }
}
