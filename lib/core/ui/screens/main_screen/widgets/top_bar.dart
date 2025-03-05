import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purple_task/core/ui/screens/about_app/about_screen.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/greetings.dart';
import 'package:purple_task/core/ui/widgets/icon_button.dart';
import 'package:purple_task/features/settings/views/settings_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: Greetings()),
        Hero(
          tag: 'about',
          child: CustomIconButton(
            icon: const Icon(AntIcons.infoCircle),
            tooltip: tr.aboutAppViewTitle,
            onPressed: () => Navigator.of(context).push(
              _createRoute(const AboutScreen()),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Hero(
          tag: 'settings',
          child: CustomIconButton(
            icon: const Icon(AntIcons.setting),
            tooltip: tr.settings,
            onPressed: () => Navigator.of(context).push(
              _createRoute(const SettingsScreen()),
            ),
          ),
        ),
      ],
    );
  }
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
