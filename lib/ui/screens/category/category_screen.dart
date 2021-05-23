import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/strings/strings.dart' as s;
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

enum CategoryScreenStatus { data, remove }

final categoryScreenStatusProvider =
    StateProvider((_) => CategoryScreenStatus.data);

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

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
      duration: const Duration(milliseconds: 300),
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
        print(value.state);
        if (value.state == CategoryScreenStatus.remove) {
          Navigator.of(context).pop();
        }
      },
      child: Consumer(
        builder: (context, watch, _) {
          final currentCategory = watch(currentCategoryProvider).state;
          final categoryName = watch(categoryNameProvider(currentCategory!.id));
          final categoryColor =
              watch(categoryColorProvider(currentCategory.id));
          final categoryIcon = watch(categoryIconProvider(currentCategory.id));
          final tasksController = watch(tasksProvider.notifier);
          var description = '';
          final activeTasksNumber =
              watch(activeTasksNumberProvider(currentCategory.id));
          final progress = watch(progressProvider(currentCategory.id));

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
            body: LayoutBuilder(builder: (context, constrains) {
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
                            ]),
                      ),
                    ),
                  Positioned(
                    width: _isWide ? 600 : constrains.maxWidth,
                    top: _isWide ? 40 : 0,
                    bottom: _isWide ? 40 : 0,
                    child: Hero(
                      tag: 'main${currentCategory.id}',
                      child: Container(
                        decoration: _isWide
                            ? CustomStyle.dialogDecoration
                            : const BoxDecoration(color: Color(0xFFEEEEEE)),
                      ),
                    ),
                  ),
                  Positioned(
                    width: _isWide ? 600 : constrains.maxWidth,
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
                          child: AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimation.value,
                                child: child,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Go back button
                                CustomIconButton(
                                  icon: const Icon(AntIcons.arrow_left),
                                  color: Colors.white,
                                  tooltip: s.close,
                                  onPressed: () {
                                    _animationController.reverse();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                // Menu button
                                CategoryMenu(categoryId: currentCategory.id),
                              ],
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
                                Row(
                                  children: [
                                    Hero(
                                      tag: 'icon${currentCategory.id}',
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
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4.0,
                                    top: 20.0,
                                    right: 4.0,
                                    bottom: 12.0,
                                  ),
                                  child: Hero(
                                    tag: 'header${currentCategory.id}',
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
                                  child: AnimatedBuilder(
                                    animation: _fadeAnimation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: _fadeAnimation.value,
                                        child: child,
                                      );
                                    },
                                    child: AddTaskField(
                                      onAddTask: (value) {
                                        final task = Task(
                                          name: value,
                                          categoryId: currentCategory.id,
                                        );
                                        tasksController.add(task: task);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AnimatedBuilder(
                                    animation: _fadeAnimation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: _fadeAnimation.value,
                                        child: child,
                                      );
                                    },
                                    child: _buildTasksList(currentCategory),
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _fadeAnimation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _animationController.value,
                                      child: child,
                                    );
                                  },
                                  child: BottomNavigationBar(
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
                                        icon: Icon(AntIcons.check_circle),
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
            }),
          );
        },
      ),
    );
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
