import 'dart:math';

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../models/models.dart';
import '../../../../../providers/providers.dart';
import '../../../../widgets/widgets.dart';
import '../../../screens.dart';
import '../widgets.dart';
import 'selected_category_tasks.dart';
import 'vertical_categories.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appHeight = MediaQuery.of(context).size.height;
    final appWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        const AnimatedBackground(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Greetings(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: 'about',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                        child: CustomIconButton(
                          color: Colors.white,
                          icon: const Icon(AntIcons.infoCircle),
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
                          onPressed: () => Navigator.of(context)
                              .push(_createRoute(Settings())),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: min(appWidth * 0.4, 450.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Consumer(builder: (context, ref, _) {
                            final categories =
                                ref.watch(categoriesProvider).categories;
                            return VerticalList(
                              categories: categories,
                            );
                          }),
                        ),
                        Hero(
                          tag: 'new_category',
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AddCategoryButton(
                              text: s.addCategory,
                              onPressed: () => Navigator.of(context).push(
                                _createRoute(NewCategoryScreen()),
                                // _openNewCategoryCreator(context);
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 500,
                            child: Consumer(
                              builder: (context, ref, _) => AddTaskField(
                                onAddTask: (value) {
                                  final task = Task(
                                    name: value,
                                    categoryId: ref
                                            .watch(currentCategoryProvider)
                                            ?.id ??
                                        -1,
                                  );
                                  ref
                                      .read(tasksProvider.notifier)
                                      .add(task: task);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Consumer(
                              builder: (context, ref, _) {
                                return ref.watch(currentCategoryProvider) ==
                                        null
                                    ? UncategorizedTasks(
                                        width: 460,
                                        height: appHeight - 186,
                                      )
                                    : SelectedCategoryTasks(
                                        category:
                                            ref.watch(currentCategoryProvider)!,
                                        width: 460,
                                        height: appHeight - 152,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
