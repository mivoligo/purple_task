import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/globals/hive_names.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/screens/category_screen.dart';
import 'package:to_do/ui/screens/new_category_screen.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/widgets/add_category_button.dart';
import 'package:to_do/ui/widgets/category_card.dart';
import 'package:to_do/ui/widgets/greetings.dart';
import 'package:hive/hive.dart';

class HomeMobile extends StatefulWidget {
  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile>
    with SingleTickerProviderStateMixin {
  double _appWidth;
  double _appHeight;

  bool get _isPortrait => _appWidth < _appHeight;
  double _verticalPadding;
  Color _color = Colors.deepPurple;
  AnimationController _animationController;
  PageController _pageController;

  Strings s; // Strings provider

  NewCategory _newCategory; // NewCategory provider

  List<Category> _categoryList; // get list using provider

  CategoryViewModel _categoryViewModel;

  // for setting background color based on category color
  int _currentCategory = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    _verticalPadding = MediaQuery.of(context).padding.vertical;
    // get strings from Strings class
    s = Provider.of<Strings>(context, listen: false);
    _newCategory = Provider.of<NewCategory>(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _categoryList = _categoryViewModel.categoryList;
    _pageController = PageController(
      viewportFraction: (_appWidth - 48) / _appWidth,
      initialPage: 0,
    );
    // get list of categories
    _categoryViewModel.getCategory();

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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: _isPortrait ? Alignment.center : Alignment.bottomRight,
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
                              greetings: s.greetings,
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
            // Add Category button
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Positioned(
                    bottom: animDouble(_animationController, 16.0, 64.0).value,
                    right: _isPortrait ? null : 16.0,
                    child: Hero(
                      tag: 'title',
                      child: AddCategoryButton(
                        text: s.addCategory,
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
              left: _isPortrait ? 0 : _appWidth / 2,
              right: 0,
              bottom: 64.0,
              child: Container(
                height: _isPortrait
                    ? _appHeight * 0.5
                    : _appHeight - _verticalPadding - 64.0,
                child: Consumer<CategoryViewModel>(
                  builder: (_, value, __) => PageView.builder(
                    controller: _pageController,
                    itemCount: value.categoryList.length,
                    itemBuilder: (context, index) {
                      Category category = value.categoryList[index];
                      return CategoryCard(
                        name: category.name,
                        icon: category.icon,
                        color: category.color,
//                        numberOfTasks: category.tasks.length,
                        editTooltip: s.edit,
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
            ),
          ],
        ),
      ),
    );
  }

  void openCategoryScreen(BuildContext context, int index) async {
    _animationController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => CategoryScreen(
          currentCategory: _categoryList[index],
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
    _animationController.reverse();
    print('lenght is ${_categoryList.length}');
    _pageController.animateToPage(
      index - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
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
      // get length of category list from Hive
      int _categoryListLength = Hive.box<Category>(CATEGORY_BOX).length;
      _pageController.animateToPage(
        _categoryListLength,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
