import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/category_card.dart';
import 'package:to_do/ui/widgets/greetings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _appWidth;
  double _appHeight;
  Color _color = Colors.deepPurple;
  int _categoryIndex = 0;

  bool get _isPortrait => _appWidth < _appHeight;

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    print('is rebuilding');
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[850], _color, _color]),
        ),
        child: Flex(
          direction: _isPortrait ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 8.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Greetings(),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Consumer<CategoryList>(
                      builder: (_, categoryListModel, __) {
                        // set color based on category
                        _color = categoryListModel
                            .categoryList[_categoryIndex].color;
                        return PageView.builder(
                          controller: PageController(
                            // keep the same padding for all sizes
                            viewportFraction: (_appWidth - 80) / _appWidth,
                          ),
                          onPageChanged: (int index) => setState(
                            () {
                              _color =
                                  categoryListModel.categoryList[index].color;
                              _categoryIndex = index;
                            },
                          ),
                          itemCount: categoryListModel.categoryList.length,
                          itemBuilder: (context, index) => CategoryCard(
                            categoryName:
                                '${categoryListModel.categoryList[index].name}',
                            categoryColor:
                                categoryListModel.categoryList[index].color,
                            categoryIcon:
                                categoryListModel.categoryList[index].icon,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.create_new_folder),
                            SizedBox(width: 8.0),
                            Text(
                              'Add Category',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
