import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/constants.dart';
import '../../../../../controllers/controllers.dart';
import '../../../../widgets/category_list.dart';
import '../../../../widgets/simple_button.dart';
import '../add_category_button.dart';
import '../animated_background.dart';
import '../top_bar.dart';
import '../uncategorized_tasks.dart';

class NarrowLayout extends ConsumerStatefulWidget {
  const NarrowLayout({super.key});

  @override
  _NarrowLayoutState createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends ConsumerState<NarrowLayout>
    with SingleTickerProviderStateMixin {
  bool isUncategorizedVisible = true;

  late final AnimationController animationController;
  late final Animation<int> flex;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    flex = IntTween(
      begin: 1000,
      end: 0,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TopBar(),
              ),
              Expanded(
                flex: 1000 - flex.value + 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DecoratedBox(
                    decoration: CustomStyle.uncategorizedTasksDecoration,
                    child: isUncategorizedVisible
                        ? const UncategorizedTasks()
                        : const SizedBox.expand(),
                  ),
                ),
              ),
              Expanded(
                flex: flex.value + 1,
                child: isUncategorizedVisible
                    ? const SizedBox()
                    : const CategoryList(shouldPushDetails: true),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      isOutlined: true,
                      text: isUncategorizedVisible
                          ? 'Show categories'
                          : 'Hide categories',
                      onPressed: () {
                        ref
                            .read(categoryNotifierProvider.notifier)
                            .setCurrentCategory(null);
                        setState(() {
                          if (isUncategorizedVisible) {
                            isUncategorizedVisible = false;
                            animationController.reverse();
                          } else {
                            animationController.forward().whenComplete(
                                  () => isUncategorizedVisible = true,
                                );
                          }
                        });
                      },
                    ),
                    if (!isUncategorizedVisible) const AddCategoryButton(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
