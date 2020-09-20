import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../../db_models/db_models.dart';
import '../ui.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double _appWidth;
  double _appHeight;
  bool _isWide;

  Color _color = Colors.deepPurple;
  AnimationController _animationController;
  PageController _pageController;
  ScrollController _scrollController;

  NewCategoryViewModel _newCategory; // NewCategory provider

  List<Category> _categoryList;

  CategoryViewModel _categoryViewModel;

  // for setting background color based on category color
  int _currentCategory = 0;

  // for scrolling to last element after adding category
  // when app use ListView
  bool _needScroll = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _pageController = PageController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToEnd() async {
    if (_needScroll) {
      _needScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    _isWide = MediaQuery.of(context).size.width > 600;
    _newCategory = Provider.of<NewCategoryViewModel>(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _categoryList = _categoryViewModel.getListOfCategories();
    _pageController = PageController(
      viewportFraction: (_appWidth - 48) / _appWidth,
      initialPage: 0,
    );

    // set background color to category color
    if (_categoryList.isNotEmpty) {
      _color = Color(_categoryList[_currentCategory].color);
    }

    // use in various places to animate between double values
    Animation animDouble(AnimationController parent, double begin, double end) {
      return Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: parent,
        curve: Curves.ease,
      ));
    }

    // Used to scroll to end of list after adding new category
    // when using ListView
    SchedulerBinding.instance.addPostFrameCallback((_) => _scrollToEnd());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // colored background
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[850], _color, _color]),
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
                            return Greetings(
                              greetings: GREETINGS,
                              distance:
                                  animDouble(_animationController, 32.0, 60.0)
                                      .value,
                              topDistance:
                                  animDouble(_animationController, 0.0, 24.0)
                                      .value,
                            );
                          }),
                    );
                  }),
            ),
            // Settings button
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Hero(
                tag: 'settings',
                child: CustomIconButton(
                  color: Colors.white,
                  icon: Icon(AntIcons.setting),
                  tooltip: SETTINGS,
                  onPressed: () => openSettingsScreen(context),
                ),
              ),
            ),
            // About app button
            Positioned(
              top: 16.0,
              right: 64.0,
              child: Hero(
                tag: 'about',
                child: CustomIconButton(
                  color: Colors.white,
                  icon: Icon(AntIcons.info_circle),
                  tooltip: ABOUT,
                  onPressed: () => openAboutScreen(context),
                ),
              ),
            ),
            // Add Category button
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Positioned(
                    bottom: animDouble(_animationController, 16.0, 64.0).value,
                    child: Hero(
                      tag: 'new_category',
                      child: AddCategoryButton(
                        text: ADD_CATEGORY,
                        opacity:
                            animDouble(_animationController, 1.0, 0.0).value,
                        onPressed: () {
                          openNewCategory(context);
                        },
                      ),
                    ),
                  );
                }),
            // Category cards
            Positioned(
              left: 0,
              right: 0,
              bottom: 64.0,
              child: Container(
                height: _appHeight * 0.5,
                child: _isWide
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categoryList.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          Category category = _categoryList[index];
                          return Container(
                            width: 450,
                            child: CategoryCard(
                              category: category,
                              onTap: () {
                                openCategoryScreen(context, index);
                              },
                              // change background color on mouse hover
                              onHover: (v) => {
                                setState(() {
                                  _currentCategory = index;
                                })
                              },
                              // change background color when using keyboard
                              onFocusChange: (v) => {
                                setState(() {
                                  _currentCategory = index;
                                })
                              },
                            ),
                          );
                        },
                      )
                    : PageView.builder(
                        controller: _pageController,
                        itemCount: _categoryList.length,
                        itemBuilder: (context, index) {
                          Category category = _categoryList[index];
                          return CategoryCard(
                            category: category,
                            onTap: () {
                              openCategoryScreen(context, index);
                            },
                          );
                        },
                        onPageChanged: (int index) => setState(
                          () {
                            // for setting background color same as current category
                            _currentCategory = index;
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openSettingsScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => SettingsScreen(
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

  void openAboutScreen(BuildContext context) {
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

  void openCategoryScreen(BuildContext context, int index) async {
    _animationController.forward();
    _categoryViewModel.currentCategory = _categoryList[index];
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => CategoryScreen(
          currentIndex: index,
        ),
        transitionsBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1,
            child: child,
          );
        },
      ),
    );

    // need this after deleting last category in the list
    // otherwise _currentCategory is too big
    if (_currentCategory >
        _categoryViewModel.getListOfCategories().length - 1) {
      _currentCategory = _currentCategory - 1;
    }

    _animationController.reverse();
  }

  void openNewCategory(BuildContext context) async {
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

    if (_newCategory.addingNewCategoryCompleted) {
      // make sure _currentCategory is 0 after adding first new category
      if (_currentCategory < 0) _currentCategory = 0;
      // get length of category list from Hive
      int _categoryListLength = _categoryList.length;
      // try to go to the created category
      if (_isWide) {
        _needScroll = true;
      } else {
        _pageController.animateToPage(
          _categoryListLength,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
  }
}
