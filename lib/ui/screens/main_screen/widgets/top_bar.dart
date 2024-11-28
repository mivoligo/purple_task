import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../../screens.dart';
import 'greetings.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: Greetings()),
        CustomIconButton(
          icon: const Icon(AntIcons.areaChart),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
        Hero(
          tag: 'about',
          child: CustomIconButton(
            icon: const Icon(AntIcons.infoCircle),
            onPressed: () => Navigator.of(context).push(
              _createRoute(AboutScreen()),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Hero(
          tag: 'settings',
          child: CustomIconButton(
            icon: const Icon(AntIcons.setting),
            onPressed: () => Navigator.of(context).push(
              _createRoute(Settings()),
            ),
          ),
        ),
      ],
    );
  }
}

Route _createRoute(Widget target) {
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
