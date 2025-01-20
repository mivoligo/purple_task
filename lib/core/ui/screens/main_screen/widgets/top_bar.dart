import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:purple_task/core/ui/screens/about_app/about_screen.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/greetings.dart';
import 'package:purple_task/core/ui/screens/settings/settings.dart';
import 'package:purple_task/core/ui/widgets/icon_button.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: Greetings()),
        Hero(
          tag: 'about',
          child: CustomIconButton(
            icon: const Icon(AntIcons.infoCircle),
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
            onPressed: () => Navigator.of(context).push(
              _createRoute(const Settings()),
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
