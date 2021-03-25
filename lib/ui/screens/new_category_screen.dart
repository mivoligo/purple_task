import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../globals/globals.dart';
import '../ui.dart';

enum Progress {
  CategoryName,
  CategoryColor,
  CategoryIcon,
  CategoryTasks,
}

class NewCategoryScreen extends StatefulWidget {
  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  Progress progress = Progress.CategoryName;
  late NewCategoryViewModel newCategoryProvider;
  CategoryViewModel? categoryDb;
  FocusNode? _focusNode;

  Widget getProgressWidget() {
    switch (progress) {
      case Progress.CategoryName:
        return CategoryName(
          onSubmitted: (_) => goToColorSelector(),
        );
      case Progress.CategoryColor:
        return CategoryColor();
      case Progress.CategoryIcon:
        return CategoryIcon();
      case Progress.CategoryTasks:
        return CategoryTasks();
    }
  }

  void goToNext() {
    switch (progress) {
      case Progress.CategoryName:
        goToColorSelector();
        break;
      case Progress.CategoryColor:
        goToIconSelector();
        break;
      case Progress.CategoryIcon:
        newCategoryProvider.setCategoryId();
        goToAddingTasks();
        break;
      case Progress.CategoryTasks:
        newCategoryProvider.addNewCategory(context);
        newCategoryProvider.addTasksToDb(context);
        newCategoryProvider.addingNewCategoryCompleted = true;
        Navigator.of(context).pop();
        break;
    }
  }

  void goToColorSelector() {
    if (newCategoryProvider.name.isNotEmpty) {
      setState(() {
        progress = Progress.CategoryColor;
        _focusNode!.requestFocus();
      });
    }
  }

  void goToIconSelector() {
    setState(() {
      progress = Progress.CategoryIcon;
    });
  }

  void goToAddingTasks() {
    setState(() {
      progress = Progress.CategoryTasks;
    });
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    newCategoryProvider.resetNewCategory();
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _appWidth = MediaQuery.of(context).size.width;
    double _appHeight = MediaQuery.of(context).size.height;
    double _verticalPadding = MediaQuery.of(context).padding.vertical;
    double _verticalInset = MediaQuery.of(context).viewInsets.vertical;
    double _cardWidth = min(550, _appWidth - 64);
    double _cardHeight =
        min(400, _appHeight - _verticalPadding - _verticalInset - 32.0);
    newCategoryProvider = Provider.of<NewCategoryViewModel>(context);
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Consumer<NewCategoryViewModel>(
              builder: (_, value, __) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey[850]!,
                        Color(value.color),
                        Color(value.color),
                      ]),
                ),
              ),
            ),
            Center(
              child: Hero(
                tag: 'new_category',
                child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 4.0,
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: _cardWidth,
                      height: _cardHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 32.0,
                            top: 24.0,
                            child: Consumer<NewCategoryViewModel>(
                              builder: (_, value, __) => AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: progress == Progress.CategoryIcon ||
                                        progress == Progress.CategoryTasks
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
                              const SizedBox(height: 8.0),
                              Text(
                                NEW_CATEGORY,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                flex: 3,
                                child: getProgressWidget(),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 16.0),
                                  SimpleButton(
                                    text: CANCEL,
                                    onPressed: () {
                                      Provider.of<NewCategoryViewModel>(context,
                                              listen: false)
                                          .addingNewCategoryCompleted = false;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Spacer(),
                                  SimpleButton(
                                    focusNode: _focusNode,
                                    text: progress == Progress.CategoryTasks
                                        ? FINISH
                                        : NEXT,
                                    color: Colors.green,
                                    onPressed: newCategoryProvider.name.isEmpty
                                        ? null
                                        : goToNext,
                                  ),
                                  const SizedBox(width: 16.0),
                                ],
                              ),
                              const SizedBox(height: 16.0),
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
