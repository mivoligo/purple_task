import 'dart:math' as math;

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({required this.heroId});

  final int heroId;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;

  // Index for bottom navigation
  late int _navigationIndex = 0;

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
    return ProviderListener<StateController<CategoryScreenStatus>>(
      provider: categoryScreenStatusProvider,
      onChange: (context, value) {
        if (value.state == CategoryScreenStatus.remove) {
          Navigator.of(context).pop();
        }
      },
      child: Consumer(
        builder: (context, watch, _) {
          final currentCategory = watch(currentCategoryProvider).state;

          final categoryName = currentCategory?.name ?? '';
          final categoryColor = currentCategory?.color ?? Colors.transparent;
          final categoryIcon = currentCategory?.icon ?? 1;
          final tasksController = watch(tasksProvider.notifier);
          var description = '';
          final activeTasksNumber =
              watch(activeTasksNumberProvider(currentCategory?.id));
          final progress = watch(progressProvider(currentCategory?.id));

          switch (activeTasksNumber) {
            case 0:
              description = '$activeTasksNumber ${s.taskPlural}';
              break;
            case 1:
              description = '$activeTasksNumber ${s.taskSingular}';
              break;
            default:
              description = '$activeTasksNumber ${s.taskPlural}';
          }

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constrains) {
                var _isWide = constrains.maxWidth > 600;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isWide)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF303030),
                              categoryColor,
                              categoryColor,
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      width: _isWide
                          ? math.min((constrains.maxWidth - 80), 600)
                          : constrains.maxWidth,
                      top: _isWide ? 40 : 0,
                      bottom: _isWide ? 40 : 0,
                      child: Hero(
                        tag: 'main${widget.heroId}',
                        child: Container(
                          decoration: _isWide
                              ? CustomStyle.dialogDecoration
                              : const BoxDecoration(color: Color(0xFFEEEEEE)),
                        ),
                      ),
                    ),
                    Positioned(
                      width: _isWide
                          ? math.min((constrains.maxWidth - 80), 600)
                          : constrains.maxWidth,
                      top: _isWide ? 40 : 0,
                      bottom: _isWide ? 40 : 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                              right: 8.0,
                            ),
                            child: AnimatedOpacityBuilder(
                              animation: _fadeAnimation,
                              content: TopBar(
                                onRemoveAllTasks: () =>
                                    _removeAllTasks(context),
                                onRemoveCompletedTasks: () =>
                                    _removeCompletedTasks(context),
                                onRemoveCategory: () =>
                                    _removeCategoryAndTasks(context),
                                onClose: () => _animationController.reverse(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 32.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Hero(
                                    tag: 'icon${widget.heroId}',
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Icon(
                                        IconData(
                                          categoryIcon,
                                          fontFamily: 'AntIcons',
                                          fontPackage: 'ant_icons',
                                        ),
                                        size: 42.0,
                                        color: categoryColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4.0,
                                      top: 20.0,
                                      right: 4.0,
                                      bottom: 12.0,
                                    ),
                                    child: Hero(
                                      tag: 'header${widget.heroId}',
                                      // get rid of overflow error
                                      // https://github.com/flutter/flutter/issues/27320
                                      flightShuttleBuilder: (
                                        flightContext,
                                        animation,
                                        flightDirection,
                                        fromHeroContext,
                                        toHeroContext,
                                      ) {
                                        return SingleChildScrollView(
                                          child: fromHeroContext.widget,
                                        );
                                      },
                                      child: CategoryHeader(
                                        title: categoryName,
                                        description: description,
                                        progress: progress,
                                        color: categoryColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: AnimatedOpacityBuilder(
                                      animation: _fadeAnimation,
                                      content: AddTaskField(
                                        onAddTask: (value) {
                                          final task = Task(
                                            name: value,
                                            categoryId:
                                                currentCategory?.id ?? 0,
                                          );
                                          tasksController.add(task: task);
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedOpacityBuilder(
                                      animation: _fadeAnimation,
                                      content: currentCategory != null
                                          ? _buildTasksList(currentCategory)
                                          : const SizedBox(),
                                    ),
                                  ),
                                  AnimatedOpacityBuilder(
                                    animation: _fadeAnimation,
                                    content: BottomNavigationBar(
                                      type: BottomNavigationBarType.fixed,
                                      unselectedFontSize: 14.0,
                                      currentIndex: _navigationIndex,
                                      onTap: (index) {
                                        setState(() {
                                          _navigationIndex = index;
                                        });
                                      },
                                      items: [
                                        const BottomNavigationBarItem(
                                          label: s.toDo,
                                          icon: Icon(AntIcons.edit),
                                        ),
                                        const BottomNavigationBarItem(
                                          label: s.all,
                                          icon: Icon(AntIcons.profile),
                                        ),
                                        const BottomNavigationBarItem(
                                          label: s.completed,
                                          icon: Icon(AntIcons.checkCircle),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _removeAllTasks(BuildContext context) {
    final currentCategory = context.read(currentCategoryProvider).state;
    if (currentCategory != null) {
      context
          .read(tasksProvider.notifier)
          .removeAllTasksForCategory(categoryId: currentCategory.id);
    }
  }

  void _removeCompletedTasks(BuildContext context) {
    final currentCategory = context.read(currentCategoryProvider).state;
    if (currentCategory != null) {
      context
          .read(tasksProvider.notifier)
          .removeCompletedTasksForCategory(categoryId: currentCategory.id);
    }
  }

  void _removeCategoryAndTasks(BuildContext context) {
    final currentCategory = context.read(currentCategoryProvider).state;
    if (currentCategory != null) {
      // delete tasks with category id
      _removeAllTasks(context);
      // change state so the page will pop
      context.read(categoryScreenStatusProvider).state =
          CategoryScreenStatus.remove;
      // delete category
      context
          .read(categoriesProvider.notifier)
          .remove(category: currentCategory);
      // remove category from current category state
      context.read(currentCategoryProvider).state = null;
    }
  }

  Widget _buildTasksList(Category category) {
    switch (_navigationIndex) {
      case 0:
        return PlannedTasks(categoryId: category.id);
      case 1:
        return AllTasks(categoryId: category.id);
      case 2:
        return CompletedTasks(categoryId: category.id);
      default:
        return PlannedTasks(categoryId: category.id);
    }
  }
}
