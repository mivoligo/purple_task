import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import '../../../../globals/strings/strings.dart' as s;
import '../../../widgets/widgets.dart';
import '../../screens.dart';
import 'widgets.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Hero(
              tag: 'about',
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: CustomIconButton(
                  color: Colors.white,
                  icon: const Icon(AntIcons.info_circle),
                  tooltip: s.about,
                  onPressed: () =>
                      Navigator.of(context).push(_createRoute(AboutScreen())),
                ),
              ),
            ),
            Hero(
              tag: 'settings',
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: CustomIconButton(
                  color: Colors.white,
                  icon: const Icon(AntIcons.setting),
                  tooltip: s.settings,
                  onPressed: () =>
                      Navigator.of(context).push(_createRoute(Settings())),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
              // color: Colors.green,
              ),
        ),
        SizedBox(
          height: 260,
          child: CategoryList(),
        ),
        Hero(
          tag: 'new_category',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddCategoryButton(
              text: s.addCategory,
              onPressed: () => Navigator.of(context).push(
                _createRoute(NewCategoryScreen()),
              ),
            ),
          ),
        ),
      ],
    );
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
}
