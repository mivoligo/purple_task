import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/custom_styles.dart';
import '../../../../../constants/strings/strings.dart' as s;
import '../../../../../controllers/controllers.dart';
import '../../../../../models/models.dart';
import '../../../../widgets/add_task_field.dart';
import '../../../../widgets/category_list.dart';
import '../../../../widgets/icon_button.dart';
import '../../../../widgets/simple_button.dart';
import '../../../screens.dart';
import '../add_category_button.dart';
import '../animated_background.dart';
import '../greetings.dart';
import '../uncategorized_tasks.dart';

class NarrowLayout extends ConsumerStatefulWidget {
  const NarrowLayout({super.key});

  @override
  _NarrowLayoutState createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends ConsumerState<NarrowLayout> {
  bool hideCategories = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBackground(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                right: 16,
                child: Row(
                  children: [
                    Hero(
                      tag: 'about',
                      child: CustomIconButton(
                        icon: const Icon(AntIcons.infoCircle),
                        onPressed: () => Navigator.of(context).push(
                          _createRoute(AboutScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
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
                ),
              ),
              Positioned(
                top: 16,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Greetings(),
                    const SizedBox(height: 8),
                    SimpleButton(
                      isOutlined: true,
                      text: 'More statistics',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                top: 128,
                bottom: hideCategories ? 64 : constraints.maxHeight,
                width: constraints.maxWidth,
                duration: Duration(milliseconds: hideCategories ? 300 : 300),
                child: hideCategories
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DecoratedBox(
                          decoration: CustomStyle.uncategorizedTasksDecoration,
                          child: Column(
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        s.noCategory,
                                        style: CustomStyle.textStyleTaskFilter,
                                      ),
                                    ),
                                    Flexible(child: UncategorizedTasks()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AddTaskField(
                                  onAddTask: (value) {
                                    final task = Task(
                                      name: value,
                                      categoryId: -1,
                                    );
                                    ref
                                        .read(tasksNotifierProvider.notifier)
                                        .add(task: task);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              AnimatedPositioned(
                top: hideCategories ? constraints.maxHeight - 80 : 128,
                height: hideCategories ? 84 : constraints.maxHeight - 128,
                width: constraints.maxWidth,
                duration: Duration(milliseconds: hideCategories ? 300 : 300),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: hideCategories
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleButton(
                              isOutlined: true,
                              text: hideCategories
                                  ? 'Show categories'
                                  : 'Hide categories',
                              onPressed: () {
                                ref
                                    .read(categoryNotifierProvider.notifier)
                                    .setCurrentCategory(null);
                                setState(() {
                                  hideCategories = !hideCategories;
                                });
                              },
                            ),
                            if (!hideCategories)
                              AddCategoryButton(
                                text: 'Add new',
                                onPressed: () => Navigator.of(context).push(
                                  _createRoute(NewCategoryScreen()),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (!hideCategories)
                        const Expanded(child: CategoryList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
