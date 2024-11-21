import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/custom_styles.dart';
import '../../../../../constants/strings/strings.dart';
import '../../../../../controllers/controllers.dart';
import '../../../../../models/models.dart';
import '../../../../widgets/add_task_field.dart';
import '../../../../widgets/category_list.dart';
import '../../../../widgets/icon_button.dart';
import '../add_category_button.dart';
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
    return DecoratedBox(
      decoration: CustomStyle.standardBackground,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                top: 8,
                right: 16,
                child: Row(
                  children: [
                    CustomIconButton(
                      icon: const Icon(AntIcons.infoCircle),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    CustomIconButton(
                      icon: const Icon(AntIcons.setting),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                left: 20,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Greetings(),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.white),
                        ),
                      ),
                      child: const Text('More statistics'),
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
                        padding: const EdgeInsets.all(20.0),
                        child: DecoratedBox(
                          decoration: CustomStyle.uncategorizedTasksDecoration,
                          child: Column(
                            children: [
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
                              Flexible(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        noCategory,
                                        style: CustomStyle.textStyleTaskFilter,
                                      ),
                                    ),
                                    Flexible(child: UncategorizedTasks()),
                                  ],
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
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: hideCategories
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              style: const ButtonStyle(
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  hideCategories = !hideCategories;
                                });
                              },
                              child: Text(
                                hideCategories
                                    ? 'Show Categories'
                                    : 'Hide Categories',
                              ),
                            ),
                            if (!hideCategories)
                              AddCategoryButton(
                                text: 'Add new',
                                onPressed: () {},
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
          );
        },
      ),
    );
  }
}
