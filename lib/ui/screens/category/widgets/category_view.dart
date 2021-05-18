import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/strings/strings.dart' as s;
import '../../../../controllers/controllers.dart';
import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({required this.categoryId});

  final int categoryId;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 32.0,
      ),
      child: Consumer(
        builder: (context, watch, _) {
          final categoryName = watch(categoryNameProvider(widget.categoryId));
          final categoryColor = watch(categoryColorProvider(widget.categoryId));
          final categoryIcon = watch(categoryIconProvider(widget.categoryId));
          final tasksController = watch(tasksProvider.notifier);
          final filteredTasks = watch(filteredTasksProvider(widget.categoryId));
          var description = '';
          final activeTasksNumber =
              watch(activeTasksNumberProvider(widget.categoryId));
          final progress = watch(progressProvider(widget.categoryId));
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'icon${widget.categoryId}',
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
                  tag: 'header${widget.categoryId}',
                  // get rid of overflow error
                  // https://github.com/flutter/flutter/issues/27320
                  flightShuttleBuilder: (
                    flightContext,
                    animation,
                    flightDirection,
                    fromHeroContext,
                    toHeroContext,
                  ) {
                    return const SizedBox();
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
                    addTask: (value) {
                      final task = Task(
                        name: value,
                        categoryId: widget.categoryId,
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
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskItem(task: task);
                    },
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
