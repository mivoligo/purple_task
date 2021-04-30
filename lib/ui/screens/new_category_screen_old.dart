import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../globals/globals.dart';
import '../../view_models/view_models.dart';
import '../ui.dart';

enum Progress {
  categoryName,
  categoryColor,
  categoryIcon,
  categoryTasks,
}

class NewCategoryScreenOld extends StatefulWidget {
  @override
  _NewCategoryScreenOldState createState() => _NewCategoryScreenOldState();
}

class _NewCategoryScreenOldState extends State<NewCategoryScreenOld> {
  Progress progress = Progress.categoryName;
  late NewCategoryViewModel newCategoryProvider;
  CategoryViewModel? categoryDb;
  FocusNode? _focusNode;

  Widget getProgressWidget() {
    switch (progress) {
      case Progress.categoryName:
        return CategoryName(
          onSubmitted: (_) => goToColorSelector(),
        );
      case Progress.categoryColor:
        return CategoryColor();
      case Progress.categoryIcon:
        return CategoryIcon();
      case Progress.categoryTasks:
        return CategoryTasks();
    }
  }

  void goToNext() {
    switch (progress) {
      case Progress.categoryName:
        goToColorSelector();
        break;
      case Progress.categoryColor:
        goToIconSelector();
        break;
      case Progress.categoryIcon:
        newCategoryProvider.setCategoryId();
        goToAddingTasks();
        break;
      case Progress.categoryTasks:
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
        progress = Progress.categoryColor;
        _focusNode!.requestFocus();
      });
    }
  }

  void goToIconSelector() {
    setState(() {
      progress = Progress.categoryIcon;
    });
  }

  void goToAddingTasks() {
    setState(() {
      progress = Progress.categoryTasks;
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
    final _appWidth = MediaQuery.of(context).size.width;
    final _appHeight = MediaQuery.of(context).size.height;
    final _verticalPadding = MediaQuery.of(context).padding.vertical;
    final _verticalInset = MediaQuery.of(context).viewInsets.vertical;
    final _cardWidth = min(550, _appWidth - 64).toDouble();
    final _cardHeight =
        min(400, _appHeight - _verticalPadding - _verticalInset - 32.0)
            .toDouble();
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
                        value.color,
                        value.color,
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
                                opacity: progress == Progress.categoryIcon ||
                                        progress == Progress.categoryTasks
                                    ? 1.0
                                    : 0.0,
                                child: Icon(
                                  IconData(
                                    value.icon,
                                    fontFamily: 'AntIcons',
                                    fontPackage: 'ant_icons',
                                  ),
                                  size: 40,
                                  color: value.color,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 8.0),
                              Text(
                                newCategory,
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
                                    text: cancel,
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
                                    text: progress == Progress.categoryTasks
                                        ? finish
                                        : next,
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
