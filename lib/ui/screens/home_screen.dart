import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/view_models/category_model.dart';
import 'package:to_do/ui/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _appWidth;
  double _appHeight;
  Color _color = Colors.white70;

  bool get _isPortrait => _appWidth < _appHeight;

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: _color,
        child: Flex(
          direction: _isPortrait ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Text('Monday 25 September'),
            ),
            Expanded(
              flex: 6,
              child: Consumer<CategoryList>(
                builder: (_, categoryListModel, __) => PageView.builder(
                  controller: PageController(
                    // keep the same padding for all sizes
                    viewportFraction: (_appWidth - 80) / _appWidth,
                  ),
                  onPageChanged: (int index) => setState(() {
                    _color = categoryListModel.categoryList.length > index
                        ? categoryListModel.categoryList[index].color
                        : Colors.black;
                  }),
                  itemCount: categoryListModel.categoryList.length + 1,
                  itemBuilder: (context, index) => CategoryCard(
                    categoryName: categoryListModel.categoryList.length > index
                        ? '${categoryListModel.categoryList[index].name}'
                        : '$index',
                    isEmpty: index == categoryListModel.categoryList.length
                        ? true
                        : false,
                    paddingLeft: index == 0 ? 0.0 : 16.0,
                    paddingRight: index == categoryListModel.categoryList.length
                        ? 0.0
                        : 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
