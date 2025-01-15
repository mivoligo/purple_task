import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart';
import 'package:purple_task/core/hive_legacy/providers/providers.dart';
import 'package:purple_task/core/migrator/views/migrate_from_hive_page.dart';
import 'package:purple_task/core/ui/screens/main_screen/main_screen.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({this.appVersion, super.key});

  final int? appVersion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      ...[
                        const Text('Welcome!'),
                        const Text('This is version 2.0 of Purple Task'),
                      ],
                      const Text("Main changes in this version:"),
                      const Text(
                        'UI was redesigned to vastly improve viewing and organizing categories in the narrow view',
                      ),
                      const Text(
                        'Categories now can easily be rearanged by drag&drop',
                      ),
                      // gif
                      Image.asset(
                        'assets/images/purple-reorder-categories.gif',
                      ),
                      const Text('The same works for ordering tasks'),
                      // gif
                      Image.asset(
                        'assets/images/purple-reorder-tasks.gif',
                        width: MediaQuery.sizeOf(context).width / 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: SimpleButton(
                onPressed: () async {
                  final hasAnyHiveBox =
                      await ref.read(hasAnyHiveBoxProvider.future);
                  if (context.mounted) {
                    await Navigator.of(context)
                        .pushReplacement(_createRoute(hasAnyHiveBox));
                  }
                },
                text: continueToNext,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route<void> _createRoute(bool hasAnyHiveBox) {
    Widget target() {
      if (hasAnyHiveBox) {
        return const MigrateFromHivePage();
      }
      return const MainScreen();
    }

    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => target(),
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}
