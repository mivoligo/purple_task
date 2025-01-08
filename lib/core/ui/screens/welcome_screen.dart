import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/migrator/providers/providers.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/animated_background.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({this.appVersion, super.key});

  final int? appVersion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBackground(
      child: Center(
        child: Column(
          children: [
            SimpleButton(
              onPressed: () async {
                if (await Hive.boxExists(settingsBox)) {
                  await ref
                      .read(settingsMigratorProvider)
                      .migrateSettingsFromHiveToSharedPreferences();
                }
              },
              text: 'Press me!',
            ),
            SimpleButton(
              onPressed: () async {
                if (await Hive.boxExists(categoryBox)) {
                  await ref
                      .read(categoriesMigratorProvider)
                      .migrateCategoriesFromHiveToDrift();
                }
              },
              text: 'Press me for categories!',
            ),
            SimpleButton(
              onPressed: () async {
                if (await Hive.boxExists(taskBox)) {
                  await ref
                      .read(tasksMigratorProvider)
                      .migrateTasksFromHiveToDrift();
                }
              },
              text: 'Press me for tasks!',
            ),
          ],
        ),
      ),
    );
  }
}
