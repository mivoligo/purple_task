import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../../widgets/widgets.dart';
import '../../../screens.dart';
import '../widgets.dart';
import 'category_list.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Consumer(
          builder: (context, watch, _) {
            final backgroundColor = watch(backgroundColorNarrowLayoutProvider);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF303030),
                      backgroundColor,
                      backgroundColor,
                    ]),
              ),
            );
          },
        ),
        Column(
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
                      onPressed: () => Navigator.of(context)
                          .push(_createRoute(AboutScreen())),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(top: 0, left: 30, child: Greetings()),
                  Positioned(
                    top: 80,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 440,
                          child: AddTaskField(
                            onAddTask: (value) {
                              final task = Task(
                                name: value,
                                categoryId: -1,
                              );
                              context
                                  .read(tasksProvider.notifier)
                                  .add(task: task);
                            },
                          ),
                        ),
                        const SizedBox(height: 1.0),
                        UncategorizedTasks(
                          width: 400,
                          height: appHeight - 542,
                        ),
                      ],
                    ),
                  ),
                ],
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
