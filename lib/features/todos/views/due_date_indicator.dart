import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/todos/models/task.dart';

class DueDateIndicator extends StatelessWidget {
  const DueDateIndicator({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer(
      builder: (context, ref, _) {
        final dateFormatSetting =
            ref.watch(settingsNotifierProvider).value?.dateFormat;

        return Row(
          children: [
            Icon(
              AntIcons.calendarOutline,
              size: 14,
              color: task.isDone
                  ? colorScheme.onSurface.withAlpha(180)
                  : colorScheme.onSurface,
            ),
            const SizedBox(width: 2),
            Text(
              _formatDueDate(
                task.dueDate,
                dateFormatSetting,
                AppLocalizations.of(context),
              ),
              style: CustomStyle.textStyleLabelSmall.copyWith(
                color: task.isDone
                    ? colorScheme.onSurface.withAlpha(180)
                    : colorScheme.onSurface,
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDueDate(
    int? dateInMillis,
    String? dateFormat,
    AppLocalizations tr,
  ) {
    if (dateInMillis != null) {
      final now = DateTime.now();
      final yesterdayDate = DateTime(now.year, now.month, now.day - 1);
      final todayDate = DateTime(now.year, now.month, now.day);
      final tomorrowDate = DateTime(now.year, now.month, now.day + 1);
      final dueDateTime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
      final dueDate =
          DateTime(dueDateTime.year, dueDateTime.month, dueDateTime.day);

      if (dueDate == todayDate) {
        return tr.today;
      } else if (dueDate == tomorrowDate) {
        return tr.tomorrow;
      } else if (dueDate == yesterdayDate) {
        return tr.yesterday;
      } else {
        return DateFormat(dateFormat).format(dueDate);
      }
    }
    return tr.noDate;
  }
}
