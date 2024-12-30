import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/custom_styles.dart';
import '../../../core/constants/strings/strings.dart' as s;
import '../../../core/ui/widgets/animated_opacity_builder.dart';
import '../controllers/categories_controller.dart';
import '../models/category.dart';
import '../providers/providers.dart';
import 'category_details.dart';
import 'category_element_base.dart';
import 'category_top_bar.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({required this.category, required this.heroId});

  final int heroId;
  final Category category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;

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
    final currentCategory = ref
        .watch(categoriesNotifierProvider)
        .valueOrNull
        ?.firstWhere((element) => element.id == widget.category.id);
    // final categoryColor = currentCategory?.color;
    final activeTasksNumber =
        ref.watch(numberOfActiveTasksInCategoryProvider(currentCategory?.id));
    final progress =
        ref.watch(completionProgressProvider(currentCategory?.id ?? 0));

    final description = switch (activeTasksNumber) {
      0 => '$activeTasksNumber ${s.taskPlural}',
      1 => '$activeTasksNumber ${s.taskSingular}',
      _ => '$activeTasksNumber ${s.taskPlural}',
    };

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
                  width: math.min((constrains.maxWidth - 24), 600),
                  top: 12,
                  bottom: 12,
                  child: Hero(
                    tag: 'main${widget.heroId}',
                    child: Container(
                      decoration: CustomStyle.dialogDecoration,
                    ),
                  ),
                ),
                Positioned(
                  width: math.min((constrains.maxWidth - 24), 600),
                  top: 12,
                  bottom: 12,
                  child: AnimatedOpacityBuilder(
                    animation: _fadeAnimation,
                    content: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            top: 8.0,
                            right: 8.0,
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
                                  description: description,
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
