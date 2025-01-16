import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/strings/strings.dart';
import 'package:purple_task/core/helpers.dart';
import 'package:purple_task/core/migrator/controllers/controllers.dart';
import 'package:purple_task/core/migrator/models/migration_state.dart';
import 'package:purple_task/core/ui/screens/main_screen/main_screen.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';

class MigrateFromHiveScreen extends ConsumerWidget {
  const MigrateFromHiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final migrationState = ref.watch(migrationStateControllerProvider);

    final buttonText = switch (migrationState.migrationStatus) {
      MigrationStatus.idle => startMigration,
      MigrationStatus.pending => migrating,
      MigrationStatus.success => continueToNext,
      MigrationStatus.error => tryAgain,
    };

    final buttonAction = switch (migrationState.migrationStatus) {
      MigrationStatus.idle => () =>
          ref.read(migrationStateControllerProvider.notifier).migrateHive(),
      MigrationStatus.pending => null,
      MigrationStatus.success => () => Navigator.of(context)
          .pushReplacement(_createRoute(const MainScreen())),
      MigrationStatus.error => () =>
          ref.read(migrationStateControllerProvider.notifier).migrateHive(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(migrationTitle),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                spacing: 24,
                children: [
                  const Text(migrationInfo),
                  if (migrationState.errorMessage != null) ...[
                    const Text(problemHappened),
                    SelectableText(
                      '${migrationState.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    SimpleButton(
                      onPressed: () => UrlHelper().openUrl(bugsUrl),
                      text: reportBug,
                      backgroundColor: Colors.orange,
                    ),
                  ],
                  SimpleButton(
                    onPressed: buttonAction,
                    text: buttonText,
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route<void> _createRoute(Widget target) {
    return PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => target,
      transitionsBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }
}
