import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/constants/strings/strings.dart' as s;
import 'package:purple_task/core/ui/screens/main_screen/main_screen.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/migrator/providers/providers.dart';
import 'package:purple_task/features/migrator/views/migrate_from_hive_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({this.appVersion, super.key});

  final String? appVersion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${s.appName} ${s.appVersion}'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            spacing: 16,
            children: [
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    primary: true,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: [
                          const Text(
                            s.changesInVersion,
                            style: CustomStyle.textStyle20,
                          ),
                          const Text('- ${s.changesUiRedesign}'),
                          const Text('- ${s.changesCategoriesReorder}'),
                          Image.asset(
                            'assets/images/purple-reorder-categories.gif',
                          ),
                          const Text('- ${s.changesTasksReorder}'),
                          Image.asset(
                            'assets/images/purple-reorder-tasks.gif',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: SimpleButton(
                  onPressed: () async {
                    final needsMigration =
                        await ref.read(needsMigrationFromHiveProvider.future);
                    if (context.mounted) {
                      await Navigator.of(context)
                          .pushReplacement(_createRoute(needsMigration));
                    }
                  },
                  text: s.continueToNext,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route<void> _createRoute(bool needsMigration) {
    final target =
        needsMigration ? const MigrateFromHiveScreen() : const MainScreen();

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
