import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/screens/category_screen.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/add_category_button.dart';
import 'package:to_do/ui/widgets/category_card.dart';
import 'package:to_do/ui/widgets/greetings.dart';

class HomePortrait extends StatefulWidget {
  @override
  _HomePortraitState createState() => _HomePortraitState();
}

class _HomePortraitState extends State<HomePortrait>
    with SingleTickerProviderStateMixin {
  double _appWidth;
  double _appHeight;
  Color _color = Colors.deepPurple;
  int _categoryIndex = 0;
  AnimationController _animationController;

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
    // get strings from Strings class
    final s = Provider.of<Strings>(context, listen: false);
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    _color = categoryListProvider.categoryList[_categoryIndex].color;

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
                    child: AddCategoryButton(
                      text: s.addCategory,
                      opacity: animDouble(_animationController, 1.0, 0.0).value,
                      onPressed: () {
                        print('AddCategory pressed');
                      },
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
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: (_appWidth - 48) / _appWidth,
                  ),
                  itemCount: categoryListProvider.categoryList.length,
                  itemBuilder: (context, index) => CategoryCard(
                    categoryName: categoryListProvider.categoryList[index].name,
                    categoryIcon: categoryListProvider.categoryList[index].icon,
                    categoryColor:
                        categoryListProvider.categoryList[index].color,
                    editTooltip: s.edit,
                    onTap: () {
                      openCategoryScreen(context);
                    },
                  ),
                  onPageChanged: (int index) => setState(
                    () {
                      _color = categoryListProvider.categoryList[index].color;
                      _categoryIndex = index;
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

  void openCategoryScreen(BuildContext context) async {
    _animationController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => CategoryScreen(
          color: _color,
          name: 'Name',
          icon: Icons.home,
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
