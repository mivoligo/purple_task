import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/ui/screens/main_screen/widgets/top_bar.dart';
import 'package:purple_task/core/ui/widgets/simple_button.dart';
import 'package:purple_task/features/settings/controllers/settings_controller.dart';
import 'package:purple_task/features/settings/providers/providers.dart';
import 'package:purple_task/features/todos/controllers/category_controller.dart';
import 'package:purple_task/features/todos/views/add_category_button.dart';
import 'package:purple_task/features/todos/views/category_list.dart';
import 'package:purple_task/features/todos/views/uncategorized_tasks.dart';

class NarrowLayout extends ConsumerStatefulWidget {
  const NarrowLayout({super.key});

  @override
  _NarrowLayoutState createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends ConsumerState<NarrowLayout>
    with SingleTickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isUncategorizedViewPreferred =
        ref.watch(isUncategorizedViewPreferredProvider);
    if (isUncategorizedViewPreferred) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TopBar(),
            ),
            Expanded(
              flex: 1000 - flex.value + 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DecoratedBox(
                  decoration: CustomStyle.uncategorizedTasksDecoration.copyWith(
                    color: Theme.of(context).colorScheme.surface.withAlpha(180),
                  ),
                  child: isUncategorizedViewPreferred
                      ? const UncategorizedTasks()
                      : const SizedBox.expand(),
                ),
              ),
            ),
            Expanded(
              flex: flex.value + 1,
              child: isUncategorizedViewPreferred
                  ? const SizedBox()
                  : const CategoryList(shouldPushDetails: true),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleButton(
                    isOutlined: true,
                    text: isUncategorizedViewPreferred
                        ? tr.showCategoriesButton
                        : tr.hideCategoriesButton,
                    onPressed: () {
                      if (isUncategorizedViewPreferred) {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .setUncategorizedViewPreference(value: false);
                        animationController.reverse();
                      } else {
                        animationController.forward().whenComplete(
                          () {
                            ref
                                .read(settingsNotifierProvider.notifier)
                                .setUncategorizedViewPreference(value: true);
                            ref
                                .read(categoryNotifierProvider.notifier)
                                .setCurrentCategory(null);
                          },
                        );
                      }
                    },
                  ),
                  if (!isUncategorizedViewPreferred) const AddCategoryButton(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
