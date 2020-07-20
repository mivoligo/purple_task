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

class _HomePortraitState extends State<HomePortrait> {
  double _appWidth;
  double _appHeight;
  Color _color = Colors.deepPurple;
  int _categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    // get strings from Strings class
    final s = Provider.of<Strings>(context, listen: false);
    final categoryListProvider =
        Provider.of<CategoryList>(context, listen: false);
    _color = categoryListProvider.categoryList[_categoryIndex].color;

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
              child: Greetings(
                greetings: s.greetings,
              ),
            ),
            Positioned(
              bottom: 16.0,
              child: AddCategoryButton(
                text: s.addCategory,
                onPressed: () {},
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 64,
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
                  ),
                  onPageChanged: (int index) => setState(() {
                    _color = categoryListProvider.categoryList[index].color;
                    _categoryIndex = index;
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
