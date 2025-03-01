import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/time_and_date_formats.dart';
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';

class DateFormatSelector extends StatelessWidget {
  const DateFormatSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final settingsState = ref.watch(settingsNotifierProvider);
        final controller = ref.watch(settingsNotifierProvider.notifier);
        return MenuAnchor(
          menuChildren: [
            ...dateFormats.map(
              (dateFormat) => MenuItemButton(
                onPressed: () {
                  controller.setDateFormat(dateFormat: dateFormat);
                },
                child: Text(
                  TimeConverter.formatDateNow(dateFormat),
                  style: settingsState.value?.dateFormat == dateFormat
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
                settingsState.value?.dateFormat ?? 'd MMM y',
              ),
            );
          },
        );
      },
    );
  }
}
