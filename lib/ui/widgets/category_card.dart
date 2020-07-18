import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final double paddingLeft;
  final double paddingRight;

  const CategoryCard({
    Key key,
    this.categoryName,
    this.paddingLeft = 16.0,
    this.paddingRight = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _cardWidth = MediaQuery.of(context).size.width - 80;
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 16.0, paddingRight, 32.0),
      child: SizedBox(
        width: _cardWidth,
        child: Card(
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _cardWidth,
                    height: 100,
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                    child: Text(
                      categoryName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Container(
                      width: _cardWidth,
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(
                              'Add Task',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
