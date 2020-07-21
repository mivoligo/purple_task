import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool _expandedCard = false;

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

    Animation animDouble(AnimationController parent, double begin, double end) {
      return Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: parent,
        curve: Curves.ease,
      ));
    }

    void expandCard() {
      _animationController.forward();
      _expandedCard = true;
    }

    void shrinkCard() {
      _animationController.reverse();
      _expandedCard = false;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[850], _color, _color]),
              ),
            ),
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
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: animDouble(_animationController, 64.0, 0.0).value,
                  child: Container(
                    height: animDouble(
                            _animationController, _appHeight * 0.5, _appHeight)
                        .value,
                    child: PageView.builder(
                      controller: PageController(
                        viewportFraction: animDouble(
                                _animationController,
                                (_appWidth - 48) / _appWidth,
                                (_appWidth - 24) / _appWidth)
                            .value,
                      ),
                      itemCount: categoryListProvider.categoryList.length,
                      itemBuilder: (context, index) => CategoryCard(
                        categoryName:
                            categoryListProvider.categoryList[index].name,
                        categoryIcon:
                            categoryListProvider.categoryList[index].icon,
                        categoryColor:
                            categoryListProvider.categoryList[index].color,
                        onTap: _expandedCard ? shrinkCard : expandCard,
                      ),
                      onPageChanged: (int index) => setState(() {
                        _color = categoryListProvider.categoryList[index].color;
                        _categoryIndex = index;
                      }),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
