import 'dart:math' as math;

import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:purple_task/globals/strings/strings.dart' as s;
import 'package:purple_task/models/models.dart';
import 'package:purple_task/ui/screens/screens.dart';
import 'package:purple_task/ui/widgets/add_category_button.dart';
import 'package:purple_task/ui/widgets/widgets.dart';
import 'package:purple_task/view_models/view_models.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double? _appWidth;
  double? _appHeight;
  bool? _isWide;
  Size? _windowSize = WidgetsBinding.instance!.window.physicalSize;
  Size? _tempWindowSize;
  final AppWindowSize _appWindowSize = AppWindowSizePluginBased();

  Color _color = Colors.deepPurple;
  late AnimationController _animationController;
  PageController? _pageController;
  ScrollController? _scrollController;
  ScrollController? _quickListController;

  // late NewCategoryViewModel _newCategory; // NewCategory provider

  // late List<Category> _categoryList;

  // late CategoryViewModel _categoryViewModel;

  // for setting background color based on category color
  int _currentCategory = 0;

  // for scrolling to last element after adding category
  // when app use ListView
  bool _needScroll = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pageController = PageController();
    _scrollController = ScrollController();
    _quickListController = ScrollController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController!.dispose();
    _scrollController!.dispose();
    _quickListController!.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // Used to save app window size on resize
  @override
  void didChangeMetrics() {
    _tempWindowSize = WidgetsBinding.instance!.window.physicalSize;
    if (_windowSize != _tempWindowSize) {
      _windowSize = _tempWindowSize;
      _appWindowSize.saveWindowSize(_windowSize!.width, _windowSize!.height);
    }
  }

  _scrollToEnd() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController!.animateTo(_scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    _isWide = MediaQuery.of(context).size.width > 600;
    // _newCategory = Provider.of<NewCategoryViewModel>(context);
    // _categoryViewModel = Provider.of<CategoryViewModel>(context);
    // _categoryList = _categoryViewModel.getListOfCategories();
    _pageController = PageController(
      viewportFraction: (_appWidth! - 48) / _appWidth!,
      initialPage: 0,
    );

    // set background color to category color
    // if (_categoryList.isNotEmpty) {
    //   _color = _categoryList[_currentCategory].color;
    // }

    // use in various places to animate between double values
    Animation animDouble(AnimationController parent, double begin, double end) {
      return Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: parent,
        curve: Curves.ease,
      ));
    }

    // Used to scroll to end of list after adding new category
    // when using ListView
    SchedulerBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // colored background
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[850]!, _color, _color]),
              ),
            ),
            // Greetings
            Positioned(
              left: 32.0,
              top: 36.0,
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: animDouble(_animationController, 1.0, 0.0).value,
                      child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: animDouble(
                                          _animationController, 16.0, 200.0)
                                      .value,
                                ),
                                // Greetings(greetings: greetings),
                                SizedBox(
                                  height: animDouble(
                                          _animationController, 24.0, 400.0)
                                      .value,
                                ),
                              ],
                            );
                          }),
                    );
                  }),
            ),
            // Settings button
            // Positioned(
            //   top: 16.0,
            //   right: 16.0,
            //   child: Hero(
            //     tag: 'settings',
            //     child: CustomIconButton(
            //       color: Colors.white,
            //       icon: Icon(AntIcons.setting),
            //       tooltip: settings,
            //       onPressed: () => openSettingsScreen(context),
            //     ),
            //   ),
            // ),
            // About app button
            Positioned(
              top: 16.0,
              right: 72.0,
              child: Hero(
                tag: 'about',
                child: CustomIconButton(
                  color: Colors.white,
                  icon: const Icon(AntIcons.info_circle),
                  tooltip: s.about,
                  onPressed: () => _openAboutScreen(context),
                ),
              ),
            ),
            // Positioned(
            //   top: 128,
            //   child: AnimatedBuilder(
            //     animation: _animationController,
            //     builder: (context, child) {
            //       return Transform(
            //         transform: Matrix4.identity()
            //           ..setEntry(3, 2, 0.001)
            //           ..rotateX(animDouble(
            //               _animationController, 0, 70 / 180 * math.pi)
            //               .value),
            //         alignment: Alignment.center,
            //         child: child,
            //       );
            //     },
            //     child: Column(
            //       children: [
            //         Container(
            //           width: _isWide! ? 440 : _appWidth! - 64,
            //           height: 40,
            //           child: AddTaskField(
            //             addTask: () {
            //               final _taskModel = Provider.of<TaskViewModel>(context,
            //                   listen: false);
            //               final _name = _taskModel.newTaskName;
            //
            //               final task = TaskEntity(
            //                   name: _name, categoryId: -1, isDone: false);
            //               _taskModel.addTask(task);
            //             },
            //           ),
            //         ),
            //         const SizedBox(height: 1.0),
            //         UncategorizedList(
            //           appHeight: _appHeight,
            //           isWide: _isWide,
            //           appWidth: _appWidth,
            //           quickListController: _quickListController,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Add Category button
            Positioned(
              bottom: 16.0,
              child: Hero(
                tag: 'new_category',
                child: AddCategoryButton(
                  text: s.addCategory,
                  onPressed: () {
                    _openNewCategoryCreator(context);
                  },
                ),
              ),
            ),
            // Category cards
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 64.0,
            //   child: _categoryList.isNotEmpty
            //       ? Container(
            //     height: _appHeight! * 0.4,
            //     child: _isWide!
            //         ? ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: _categoryList.length,
            //       controller: _scrollController,
            //       itemBuilder: (context, index) {
            //         final category = _categoryList[index];
            //         return Container(
            //           width: 450,
            //           child: CategoryCard(
            //             category: category,
            //             onTap: () {
            //               openCategoryScreen(context, index);
            //             },
            //             // change background color on mouse hover
            //             onHover: (v) => {
            //               setState(() {
            //                 _currentCategory = index;
            //               })
            //             },
            //             // change bground color when using keyboard
            //             onFocusChange: (v) => {
            //               setState(() {
            //                 _currentCategory = index;
            //               })
            //             },
            //           ),
            //         );
            //       },
            //     )
            //         : PageView.builder(
            //       controller: _pageController,
            //       itemCount: _categoryList.length,
            //       itemBuilder: (context, index) {
            //         final category = _categoryList[index];
            //         return CategoryCard(
            //           category: category,
            //           onTap: () {
            //             openCategoryScreen(context, index);
            //           },
            //         );
            //       },
            //       onPageChanged: (index) => setState(
            //             () {
            //           // for setting background color
            //           // same as current category
            //           _currentCategory = index;
            //         },
            //       ),
            //     ),
            //   )
            //       : SizedBox(),
            // ),
          ],
        ),
      ),
    );
  }

  // void openSettingsScreen(BuildContext context) {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       pageBuilder: (context, anim1, anim2) => SettingsScreen(
  //         backgroundColor: _color,
  //       ),
  //       transitionsBuilder: (context, anim1, anim2, child) {
  //         return FadeTransition(
  //           opacity: anim1,
  //           child: child,
  //         );
  //       },
  //     ),
  //   );
  // }

  void _openAboutScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => AboutScreen(
          backgroundColor: _color,
        ),
        transitionsBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1,
            child: child,
          );
        },
      ),
    );
  }

  // void openCategoryScreen(BuildContext context, int index) async {
  //   _animationController.forward();
  //   _categoryViewModel.currentCategory = _categoryList[index];
  //   await Navigator.of(context).push(
  //     PageRouteBuilder(
  //       pageBuilder: (context, anim1, anim2) => CategoryScreen(),
  //       transitionDuration: Duration(milliseconds: 400),
  //       transitionsBuilder: (context, anim1, anim2, child) {
  //         return FadeTransition(
  //           opacity: anim1,
  //           child: child,
  //         );
  //       },
  //     ),
  //   );
  //
  //   // need this after deleting last category in the list
  //   // otherwise _currentCategory is too big
  //   if (_currentCategory >
  //       _categoryViewModel.getListOfCategories().length - 1) {
  //     _currentCategory = _currentCategory - 1;
  //   }
  //
  //   _animationController.reverse();
  // }

  void _openNewCategoryCreator(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => NewCategoryScreen(),
        transitionsBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1,
            child: child,
          );
        },
      ),
    );

    // if (_newCategory.addingNewCategoryCompleted) {
    //   // make sure _currentCategory is 0 after adding first new category
    //   if (_currentCategory < 0) _currentCategory = 0;
    //   // get length of category list from Hive
    //   final _categoryListLength = _categoryList.length;
    //   // try to go to the created category
    //   if (_isWide!) {
    //     _needScroll = true;
    //   } else {
    //     _pageController!.animateToPage(
    //       _categoryListLength,
    //       duration: Duration(milliseconds: 300),
    //       curve: Curves.ease,
    //     );
    //   }
    // }
  }
}

// class UncategorizedList extends StatelessWidget {
//   const UncategorizedList({
//     Key? key,
//     required double? appHeight,
//     required bool? isWide,
//     required double? appWidth,
//     required ScrollController? quickListController,
//   })  : _appHeight = appHeight,
//         _isWide = isWide,
//         _appWidth = appWidth,
//         _quickListController = quickListController,
//         super(key: key);
//
//   final double? _appHeight;
//   final bool? _isWide;
//   final double? _appWidth;
//   final ScrollController? _quickListController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         final hasCategories =
//             Provider.of<CategoryViewModel>(context, listen: false)
//                 .getListOfCategories()
//                 .isNotEmpty;
//         final _listHeight =
//         hasCategories ? _appHeight! * 0.6 - 260 : _appHeight! - 272;
//         final _taskModel = Provider.of<TaskViewModel>(context);
//         final quickTaskList = _taskModel.getAllTasksForCategory(-1);
//         if (quickTaskList.isNotEmpty) {
//           return Container(
//             width: _isWide! ? 400 : _appWidth! - 100,
//             decoration: BoxDecoration(
//                 color: Colors.white70,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(24),
//                   bottomRight: Radius.circular(24),
//                 )),
//             child: Row(
//               children: [
//                 SizedBox(width: 10.0),
//                 Expanded(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         noCategory,
//                         style: Theme.of(context).textTheme.subtitle1,
//                       ),
//                       LimitedBox(
//                         maxHeight: _listHeight,
//                         child: AllTasksList(
//                           categoryId: -1,
//                           controller: _quickListController,
//                           shrinkWrap: true,
//                         ),
//                       ),
//                       SizedBox(height: 10.0),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 10.0),
//               ],
//             ),
//           );
//         }
//         return SizedBox();
//       },
//     );
//   }
// }
