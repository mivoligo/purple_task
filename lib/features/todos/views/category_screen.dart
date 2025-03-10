import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_task/core/constants/custom_styles.dart';
import 'package:purple_task/core/ui/widgets/animated_opacity_builder.dart';
import 'package:purple_task/features/todos/controllers/categories_controller.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/providers/providers.dart';
import 'package:purple_task/features/todos/views/category_details.dart';
import 'package:purple_task/features/todos/views/category_element_base.dart';
import 'package:purple_task/features/todos/views/category_top_bar.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({
    required this.category,
    required this.heroId,
    super.key,
  });

  final int heroId;
  final Category category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInExpo,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final currentCategory = ref
        .watch(categoriesNotifierProvider)
        .valueOrNull
        ?.firstWhere((element) => element.id == widget.category.id);
    final activeTasksNumber =
        ref.watch(numberOfActiveTasksInCategoryProvider(currentCategory?.id));
    final progress =
        ref.watch(completionProgressProvider(currentCategory?.id ?? 0));

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constrains) {
            if (currentCategory == null) {
              return const CircularProgressIndicator();
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF303030),
                        currentCategory.color,
                        currentCategory.color,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: math.min(constrains.maxWidth - 24, 600),
                  top: 12,
                  bottom: 12,
                  child: Hero(
                    tag: 'main${widget.heroId}',
                    child: Container(
                      decoration: CustomStyle.dialogDecoration.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withAlpha(180),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: math.min(constrains.maxWidth - 24, 600),
                  top: 12,
                  bottom: 12,
                  child: AnimatedOpacityBuilder(
                    animation: _fadeAnimation,
                    content: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 8,
                            right: 8,
                          ),
                          child: CategoryTopBar(
                            onClose: () => _animationController.reverse(),
                            category: currentCategory,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: CategoryElementBase(
                                  icon: currentCategory.icon,
                                  name: currentCategory.name,
                                  description:
                                      tr.categoryTasksInfo(activeTasksNumber),
                                  progress: progress,
                                  color: currentCategory.color,
                                  iconSize: 28,
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Expanded(
                                child: CategoryDetails(
                                  category: widget.category,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
