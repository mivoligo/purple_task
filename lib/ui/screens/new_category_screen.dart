import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/category.dart';
import 'package:to_do/ui/strings/strings.dart';
import 'package:to_do/models/new_category.dart';
import 'package:to_do/ui/view_models/category_view_model.dart';
import 'package:to_do/ui/widgets/new_category/new_category_colors.dart';
import 'package:to_do/ui/widgets/new_category/new_category_icons.dart';
import 'package:to_do/ui/widgets/new_category/new_category_name.dart';

enum Progress {
  CategoryName,
  CategoryColor,
  CategoryIcon,
}

class NewCategoryScreen extends StatefulWidget {
  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  Progress progress = Progress.CategoryName;
  NewCategory newCategoryProvider;
  CategoryViewModel categoryDb;
  final FocusNode _nextButtonFocusNode = FocusNode();
  bool nextButtonAutoFocus = false;

  Widget getProgressWidget() {
    switch (progress) {
      case Progress.CategoryName:
        return CategoryName(
          onNextPressed:
              newCategoryProvider.name.isEmpty ? null : goToColorSelector,
          onSubmitted: (_) => goToColorSelector(),
        );
      case Progress.CategoryColor:
        return CategoryColor(
          onNextPressed: goToIconSelector,
        );
      case Progress.CategoryIcon:
        return CategoryIcon(
          onNextPressed: () {
            addNewCategory();
            newCategoryProvider.addingNewCategoryCompleted = true;
            Navigator.of(context).pop();
          },
        );
    }
    return CategoryName(
      onNextPressed:
          newCategoryProvider.name.isEmpty ? null : goToColorSelector,
      onSubmitted: (_) => goToColorSelector(),
    );
  }

  void focusNextButton() {
    FocusScope.of(context).requestFocus(_nextButtonFocusNode);
  }

  void goToColorSelector() {
    if (newCategoryProvider.name.isNotEmpty) {
      setState(() {
        progress = Progress.CategoryColor;
      });
    }
  }

  void goToIconSelector() {
    setState(() {
      progress = Progress.CategoryIcon;
    });
  }

  void addNewCategory() {
    String name = newCategoryProvider.name;
    int color = newCategoryProvider.color;
    int icon = newCategoryProvider.icon;
    Category category = Category(name: name, color: color, icon: icon);
    categoryDb.addCategory(category);
  }

  @override
  void dispose() {
    newCategoryProvider.resetNewCategory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _appWidth = MediaQuery.of(context).size.width;
    double _appHeight = MediaQuery.of(context).size.height;
    double _verticalPadding = MediaQuery.of(context).padding.vertical;
    double _verticalInset = MediaQuery.of(context).viewInsets.vertical;
    double _cardHeight =
        min(400, _appHeight - _verticalPadding - _verticalInset - 32.0);
    Strings s = Provider.of<Strings>(context, listen: false);
    newCategoryProvider = Provider.of<NewCategory>(context);
    categoryDb = Provider.of<CategoryViewModel>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Consumer<NewCategory>(
              builder: (_, value, __) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey[850],
                        Color(value.color),
                        Color(value.color),
                      ]),
                ),
              ),
            ),
            Center(
              child: Hero(
                tag: 'title', // TODO fix tag
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: 4.0,
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: _appWidth - 64,
                      height: _cardHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 32.0,
                            top: 24.0,
                            child: Consumer<NewCategory>(
                              builder: (_, value, __) => AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: progress == Progress.CategoryIcon
                                    ? 1.0
                                    : 0.0,
                                child: Icon(
                                  IconData(
                                    value.icon,
                                    fontFamily: 'AntIcons',
                                    fontPackage: 'ant_icons',
                                  ),
                                  size: 40,
                                  color: Color(value.color),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 8.0),
                              Text(
                                s.newCategory,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Expanded(
                                flex: 3,
                                child: getProgressWidget(),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
