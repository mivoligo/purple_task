import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/strings/strings.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/add_task_field.dart';
import 'package:to_do/ui/widgets/task_list/all_tasks_list.dart';
import 'package:to_do/ui/widgets/category_header.dart';
import 'package:to_do/ui/widgets/task_list/completed_tasks_list.dart';
import 'package:to_do/ui/widgets/task_list/planned_task_list.dart';

class CategoryScreen extends StatefulWidget {
  final Category currentCategory;
  final int currentIndex;

  const CategoryScreen({
    Key key,
    this.currentCategory,
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
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _isWide = MediaQuery.of(context).size.width > 600;
    final taskModel = Provider.of<TaskViewModel>(context);
    int categoryId = widget.currentCategory.id;
    _listOfAllTasks = taskModel.getAllTasksForCategory(categoryId);
    _listOfPlannedTasks = taskModel.getPlannedTasksForCategory(categoryId);
    _listOfCompletedTasks = taskModel.getCompletedTasksForCategory(categoryId);

    // Used to scroll to end of list after adding new task
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollToEnd();
    });

    print('category screen is rebuilding');
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
                  Color(widget.currentCategory.color),
                ],
              ),
            ),
          ),
          Positioned(
            width: _isWide ? 550 : _appWidth,
            top: _isWide ? 50 : 0,
            bottom: _isWide ? 50 : 0,
            child: Hero(
              tag: 'main${widget.currentCategory.name}',
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
                                  color: Colors.grey,
                                  tooltip: CLOSE,
                                  onPressed: () {
                                    _animationController.reverse();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Spacer(),
                                // Menu button
                                IconButton(
                                  icon: Icon(AntIcons.menu),
                                  color: Colors.grey,
                                  tooltip: EDIT,
                                  onPressed: () {
                                    Provider.of<TaskViewModel>(context,
                                            listen: false)
                                        .deleteAllTasksForCategory(
                                            widget.currentCategory.id);
                                    Provider.of<CategoryViewModel>(context,
                                            listen: false)
                                        .deleteCategory(widget.currentIndex);
                                    _animationController.reverse();
                                    Navigator.of(context).pop();
                                  },
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
                            tag: 'icon${widget.currentCategory.name}',
                            child: Icon(
                                IconData(
                                  widget.currentCategory.icon,
                                  fontFamily: 'AntIcons',
                                  fontPackage: 'ant_icons',
                                ),
                                color: Color(widget.currentCategory.color),
                                size: 40),
                          ),
                          SizedBox(height: 24.0),
                          // header with number of tasks, name and progress
                          Hero(
                            tag: 'header${widget.currentCategory.name}',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Consumer<TaskViewModel>(
                                builder: (_, model, __) {
                                  int numberOfTasks =
                                      model.numberOfPlannedTasksForCategory(
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
                                    title: widget.currentCategory.name,
                                    description: _descriptionText,
                                    progress:
                                        model.completionProgress(categoryId),
                                    color: Color(widget.currentCategory.color),
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
                                int categoryId = widget.currentCategory.id;
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
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _navigationIndex,
                onTap: (index) {
                  setState(() {
                    _navigationIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    title: Text(ALL),
                    icon: Icon(AntIcons.profile),
                  ),
                  BottomNavigationBarItem(
                    title: Text(TO_DO),
                    icon: Icon(AntIcons.edit),
                  ),
                  BottomNavigationBarItem(
                    title: Text(COMPLETED),
                    icon: Icon(AntIcons.check_circle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
