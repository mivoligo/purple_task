import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/local_db/repository/category_repository.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/ui/screens/category_screen.dart';
import 'package:to_do/ui/screens/new_category_screen.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/widgets/add_category_button.dart';
import 'package:to_do/ui/widgets/category_card.dart';
import 'package:to_do/ui/widgets/greetings.dart';

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
  int _categoryIndex = 0;
  AnimationController _animationController;
  Strings s; // Strings provider

  List<Category> categoryList;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    _verticalPadding = MediaQuery.of(context).padding.vertical;
    // get strings from Strings class
    s = Provider.of<Strings>(context, listen: false);
    categoryList =
        Provider.of<CategoryList>(context, listen: false).categoryList;

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
              child: FutureBuilder(
                future: CategoryRepository.getCategories(),
                builder: (context, snapshot) {
                  categoryList = snapshot.data;
                  return Container(
                    height: _isPortrait
                        ? _appHeight * 0.5
                        : _appHeight - _verticalPadding - 64.0,
                    child: PageView.builder(
                      controller: PageController(
                        viewportFraction: (_appWidth - 48) / _appWidth,
                      ),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        Category category = categoryList[index];
                        return CategoryCard(
                          name: category.name,
                          icon: category.icon,
                          color: category.color,
                          editTooltip: s.edit,
                          onTap: () {
                            openCategoryScreen(context, index);
                          },
                        );
                      },
                      onPageChanged: (int index) => setState(
                        () {
                          print('${categoryList[index].name}');
                          _color = Color(categoryList[index].color);
                          _categoryIndex = index;
                        },
                      ),
                    ),
                  );
                },
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
          currentCategory: categoryList[index],
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
  }

  void openNewCategory(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => NewCategoryScreen(),
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1,
              child: child,
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
