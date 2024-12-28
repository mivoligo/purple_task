import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/constants.dart';
import '../../migrator.dart';
import '../../providers/providers.dart';
import '../widgets/simple_button.dart';
import 'main_screen/widgets/animated_background.dart';

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
                  ref
                      .read(settingsMigratorProvider)
                      .migrateSettingsFromHiveToSharedPreferences();
                }
              },
              text: 'Press me!',
            ),
            SimpleButton(
              onPressed: () async {
                if (await Hive.boxExists(categoryBox)) {
                  ref
                      .read(categoriesMigratorProvider)
                      .migrateCategoriesFromHiveToDrift();
                }
              },
              text: 'Press me for categories!',
            ),
          ],
        ),
      ),
    );
  }
}
