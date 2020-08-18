import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/view_models/task_view_model.dart';
import 'package:to_do/ui/widgets/add_task_field.dart';
import 'package:to_do/ui/widgets/task_list/all_tasks_list.dart';
import 'package:to_do/ui/widgets/category_header.dart';
import 'package:to_do/ui/widgets/task_list/completed_tasks_list.dart';
import 'package:to_do/ui/widgets/task_list/planned_tasks_list.dart';

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
  double _appWidth;
  double _appHeight;

  bool get _isPortrait => _appWidth < _appHeight;

  int _navigationIndex = 0;

  Widget getTasksList(categoryId) {
    switch (_navigationIndex) {
      case 0:
        return AllTasks(
          categoryId: categoryId,
        );
        break;
      case 1:
        return PlannedTasks(categoryId: categoryId);
        break;
      case 2:
        return CompletedTasks(categoryId: categoryId);
        break;
    }
    return AllTasks(categoryId: categoryId);
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
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    Strings s = Provider.of<Strings>(context, listen: false);
    final taskModel = Provider.of<TaskViewModel>(context);
//    taskModel.getTasksForCategory(widget.currentCategory.id);
    int categoryId = widget.currentCategory.id;

    print('category screen is rebuilding');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[850],
              Color(widget.currentCategory.color),
              Color(widget.currentCategory.color)
            ],
          ),
        ),
        child: Stack(
          children: [
            Hero(
              tag: 'main${widget.currentCategory.name}',
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[200],
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0 + _paddingTop,
              right: 16.0,
              // Animation used to avoid showing back button to early
              child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Row(
                          children: [
                            // Go back button
                            IconButton(
                              icon: Icon(AntIcons.arrow_left),
                              color: Colors.grey,
                              tooltip: s.close,
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
                              tooltip: s.edit,
                              onPressed: () {
                                print(
                                    'current category = ${widget.currentIndex}');

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
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            // Category icon
            Positioned(
              left: 48.0,
              top: 92.0 + _paddingTop,
              child: Hero(
                tag: 'icon${widget.currentCategory.name}',
                child: Icon(
                  IconData(
                    widget.currentCategory.icon,
                    fontFamily: 'AntIcons',
                    fontPackage: 'ant_icons',
                  ),
                  color: Color(widget.currentCategory.color),
                  size: 40,
                ),
              ),
            ),
            // Header
            Positioned(
              left: 48.0,
              top: 148.0 + _paddingTop,
              // TODO Make sure to improve this for desktop
              right: _isPortrait ? 48.0 : _appWidth / 2 + 32.0,
              child: Hero(
                tag: 'header${widget.currentCategory.name}',
                child: Material(
                  type: MaterialType.transparency,
                  child: Consumer<TaskViewModel>(
                    builder: (_, model, __) => CategoryHeader(
                      title: widget.currentCategory.name,
                      description:
                          '${model.numberOfPlannedTasksForCategory(categoryId)} tasks',
                      progress: model.completionProgress(categoryId),
                      color: Color(widget.currentCategory.color),
                    ),
                  ),
                ),
              ),
            ),
            // Add task field
            Positioned(
              left: 48.0,
              top: 240.0 + _paddingTop,
              right: 48.0,
              bottom: 16.0,
              child: AddTaskField(
                addTask: () {
                  String name = taskModel.newTaskName;
                  int categoryId = widget.currentCategory.id;
                  Task task =
                      Task(name: name, categoryId: categoryId, isDone: false);
                  taskModel.addTask(task);
                },
              ),
            ),
            // List of tasks
            Positioned(
              left: 48.0,
              top: 290.0 + _paddingTop,
              right: 48.0,
              bottom: 16.0,
              child: getTasksList(categoryId),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (index) {
          setState(() {
            _navigationIndex = index;
          });
        },
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        items: [
          BottomNavigationBarItem(
            title: Text('All'),
            icon: Icon(AntIcons.profile),
          ),
          BottomNavigationBarItem(
            title: Text('To Do'),
            icon: Icon(AntIcons.edit),
          ),
          BottomNavigationBarItem(
            title: Text('Completed'),
            icon: Icon(AntIcons.check_circle),
          ),
        ],
      ),
    );
  }
}
