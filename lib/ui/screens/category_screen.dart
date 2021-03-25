import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../db_models/db_models.dart';
import '../../globals/globals.dart';
import '../ui.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key? key,
    this.currentIndex,
  }) : super(key: key);

  final int? currentIndex;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _fadeAnimation;
  ScrollController? _scrollController;
  late TextEditingController _categoryNameController;

  int? categoryId;

  // for scrolling to last element after adding task
  bool _needScroll = false;

  // Index for bottom navigation
  int _navigationIndex = 0;

  double? _appWidth;
  late bool _isWide;

  // display correct list according to bottom navigation
  Widget getTasksList() {
    switch (_navigationIndex) {
      case 0:
        return PlannedTasksList(
            categoryId: categoryId, controller: _scrollController);
      case 1:
        return AllTasksList(
            categoryId: categoryId, controller: _scrollController);
      case 2:
        return CompletedTasksList(
            categoryId: categoryId, controller: _scrollController);
    }
    return PlannedTasksList(
        categoryId: categoryId, controller: _scrollController);
  }

  _scrollToTop() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController!.animateTo(_scrollController!.position.minScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInExpo,
    );
    _animationController.forward();
    _scrollController = ScrollController();
    _categoryNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController!.dispose();
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _isWide = MediaQuery.of(context).size.width > 600;
    final taskModel = Provider.of<TaskViewModel>(context);
    final categoryModel = Provider.of<CategoryViewModel>(context);
    categoryId = categoryModel.currentCategory!.id;

    // Used to scroll to end of list after adding new task
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollToTop();
    });

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[850]!,
                  Color(categoryModel.currentCategory!.color!),
                ],
              ),
            ),
          ),
          Positioned(
            width: _isWide ? 550 : _appWidth,
            top: _isWide ? 50 : 0,
            bottom: _isWide ? 50 : 0,
            child: Hero(
              tag: 'main${categoryModel.currentCategory!.id}',
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: _isWide ? BorderRadius.circular(24.0) : null,
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xff45000000),
                      offset: Offset(0.0, 4.0),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        // Go back button
                        const SizedBox(width: 8.0),
                        CustomIconButton(
                          icon: Icon(AntIcons.arrow_left),
                          color: Colors.white,
                          tooltip: close,
                          onPressed: () {
                            _animationController.reverse();
                            Navigator.of(context).pop();
                          },
                        ),
                        const Spacer(),
                        // Menu button
                        CategoryMenuWidget(
                          categoryIndex: widget.currentIndex,
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            width: _isWide ? 550 : _appWidth,
            top: _isWide ? 120 : 64,
            bottom: _isWide ? 50 : 0,
            child: Scaffold(
              backgroundColor: _isWide ? Colors.transparent : Colors.grey[200],
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category icon
                          Hero(
                            tag: 'icon${categoryModel.currentCategory!.id}',
                            child: Icon(
                                IconData(
                                  categoryModel.currentCategory!.icon!,
                                  fontFamily: 'AntIcons',
                                  fontPackage: 'ant_icons',
                                ),
                                color: Color(
                                    categoryModel.currentCategory!.color!),
                                size: 40),
                          ),
                          const SizedBox(height: 24.0),
                          // header with number of tasks, name and progress
                          Hero(
                            tag: 'header${categoryModel.currentCategory!.id}',
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
                            child: Material(
                              type: MaterialType.transparency,
                              child: Consumer<TaskViewModel>(
                                builder: (_, _taskModel, __) {
                                  final numberOfTasks = _taskModel
                                      .numberOfPlannedTasksForCategory(
                                          categoryId);
                                  String _descriptionText;
                                  switch (numberOfTasks) {
                                    case 0:
                                      _descriptionText =
                                          '$numberOfTasks $taskPlural';
                                      break;
                                    case 1:
                                      _descriptionText =
                                          '$numberOfTasks $taskSingular';
                                      break;
                                    default:
                                      _descriptionText =
                                          '$numberOfTasks $taskPlural';
                                  }
                                  return CategoryHeader(
                                    title: categoryModel.currentCategory!.name,
                                    description: _descriptionText,
                                    progress: _taskModel
                                        .completionProgress(categoryId),
                                    color: Color(
                                        categoryModel.currentCategory!.color!),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Add task field
                          AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimation.value,
                                child: child,
                              );
                            },
                            child: AddTaskField(
                              addTask: () {
                                final name = taskModel.newTaskName;
                                final categoryId =
                                    categoryModel.currentCategory!.id;
                                final task = Task(
                                    name: name,
                                    categoryId: categoryId,
                                    isDone: false);
                                taskModel.addTask(task);
                                _needScroll = true;
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _fadeAnimation,
                              builder: (context, child) => Opacity(
                                opacity: _fadeAnimation.value,
                                child: child,
                              ),
                              child: getTasksList(),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) =>
                    Opacity(opacity: _fadeAnimation.value, child: child),
                child: BottomNavigationBar(
                  currentIndex: _navigationIndex,
                  onTap: (index) {
                    setState(() {
                      _navigationIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: toDo,
                      icon: Icon(AntIcons.edit),
                    ),
                    BottomNavigationBarItem(
                      label: all,
                      icon: Icon(AntIcons.profile),
                    ),
                    BottomNavigationBarItem(
                      label: completed,
                      icon: Icon(AntIcons.check_circle),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
