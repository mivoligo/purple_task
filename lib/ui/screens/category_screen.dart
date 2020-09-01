import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../globals/strings/strings.dart';
import '../../db_models/task.dart';
import '../view_models/category_view_model.dart';
import '../view_models/task_view_model.dart';
import '../widgets/add_task_field.dart';
import '../widgets/category/category_menu_widget.dart';
import '../widgets/task_list/all_tasks_list.dart';
import '../widgets/category_header.dart';
import '../widgets/task_list/completed_tasks_list.dart';
import '../widgets/task_list/planned_task_list.dart';

class CategoryScreen extends StatefulWidget {
  final int currentIndex;

  const CategoryScreen({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _fadeAnimation;
  ScrollController _scrollController;
  TextEditingController _categoryNameController;

  List<Task> _listOfAllTasks;
  List<Task> _listOfPlannedTasks;
  List<Task> _listOfCompletedTasks;

  // for scrolling to last element after adding task
  bool _needScroll = false;

  // Index for bottom navigation
  int _navigationIndex = 0;

  double _appWidth;
  bool _isWide;

  // display correct list according to bottom navigation
  Widget getTasksList() {
    switch (_navigationIndex) {
      case 0:
        return AllTasksList(
            list: _listOfAllTasks, controller: _scrollController);
        break;
      case 1:
        return PlannedTasksList(
            list: _listOfPlannedTasks, controller: _scrollController);
        break;
      case 2:
        return CompletedTasksList(
            list: _listOfCompletedTasks, controller: _scrollController);
        break;
    }
    return AllTasksList(list: _listOfAllTasks, controller: _scrollController);
  }

  _scrollToEnd() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
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
    _scrollController.dispose();
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _isWide = MediaQuery.of(context).size.width > 600;
    final taskModel = Provider.of<TaskViewModel>(context);
    final categoryModel = Provider.of<CategoryViewModel>(context);
    int categoryId = categoryModel.currentCategory.id;
    _listOfAllTasks = taskModel.getAllTasksForCategory(categoryId);
    _listOfPlannedTasks = taskModel.getPlannedTasksForCategory(categoryId);
    _listOfCompletedTasks = taskModel.getCompletedTasksForCategory(categoryId);

    // Used to scroll to end of list after adding new task
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollToEnd();
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
                  Colors.grey[850],
                  Color(categoryModel.currentCategory.color),
                ],
              ),
            ),
          ),
          Positioned(
            width: _isWide ? 550 : _appWidth,
            top: _isWide ? 50 : 0,
            bottom: _isWide ? 50 : 0,
            child: Hero(
              tag: 'main${categoryModel.currentCategory.id}',
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff45000000),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 8.0,
                      ),
                    ]),
              ),
            ),
          ),
          Positioned(
            width: _isWide ? 550 : _appWidth,
            top: _isWide ? 50 : 0,
            bottom: _isWide ? 50 : 0,
            child: Scaffold(
              backgroundColor: _isWide ? Colors.transparent : Colors.grey[200],
              body: Column(
                children: [
                  AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Row(
                              children: [
                                // Go back button
                                SizedBox(width: 8.0),
                                IconButton(
                                  icon: Icon(AntIcons.arrow_left),
                                  color: Colors.grey[700],
                                  tooltip: CLOSE,
                                  onPressed: () {
                                    _animationController.reverse();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Spacer(),
                                // Menu button
                                CategoryMenuWidget(
                                  categoryIndex: widget.currentIndex,
                                ),
                                SizedBox(width: 8.0),
                              ],
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category icon
                          Hero(
                            tag: 'icon${categoryModel.currentCategory.id}',
                            child: Icon(
                                IconData(
                                  categoryModel.currentCategory.icon,
                                  fontFamily: 'AntIcons',
                                  fontPackage: 'ant_icons',
                                ),
                                color:
                                    Color(categoryModel.currentCategory.color),
                                size: 40),
                          ),
                          SizedBox(height: 24.0),
                          // header with number of tasks, name and progress
                          Hero(
                            tag: 'header${categoryModel.currentCategory.id}',
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
                                  int numberOfTasks = _taskModel
                                      .numberOfPlannedTasksForCategory(
                                          categoryId);
                                  String _descriptionText;
                                  switch (numberOfTasks) {
                                    case 0:
                                      _descriptionText =
                                          '$numberOfTasks $TASK_PLURAL';
                                      break;
                                    case 1:
                                      _descriptionText =
                                          '$numberOfTasks $TASK_SINGULAR';
                                      break;
                                    default:
                                      _descriptionText =
                                          '$numberOfTasks $TASK_PLURAL';
                                  }
                                  return CategoryHeader(
                                    title: categoryModel.currentCategory.name,
                                    description: _descriptionText,
                                    progress: _taskModel
                                        .completionProgress(categoryId),
                                    color: Color(
                                        categoryModel.currentCategory.color),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
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
                                String name = taskModel.newTaskName;
                                int categoryId =
                                    categoryModel.currentCategory.id;
                                Task task = Task(
                                    name: name,
                                    categoryId: categoryId,
                                    isDone: false);
                                taskModel.addTask(task);
                                _needScroll = true;
                              },
                            ),
                          ),
                          SizedBox(height: 16.0),
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
                      label: ALL,
                      icon: Icon(AntIcons.profile),
                    ),
                    BottomNavigationBarItem(
                      label: TO_DO,
                      icon: Icon(AntIcons.edit),
                    ),
                    BottomNavigationBarItem(
                      label: COMPLETED,
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
