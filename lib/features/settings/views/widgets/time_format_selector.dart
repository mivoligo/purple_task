import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/time_and_date_formats.dart';
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';

class TimeFormatSelector extends StatelessWidget {
  const TimeFormatSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                  // style: settingsState.value?.timeFormat == timeFormat
                  //     ? CustomStyle.textStyleTaskName
                  //         .copyWith(color: Theme.of(context).colorScheme.primary)
                  //     : CustomStyle.textStyleTaskName,
                ),
              ),
            ),
          ],
          builder: (context, controller, child) {
            return SimpleButton(
              foregroundColor: colorScheme.surface,
              backgroundColor: colorScheme.onSurface.withAlpha(180),
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
