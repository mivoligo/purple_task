import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final bool isEmpty;
  final String categoryName;
  final double paddingLeft;
  final double paddingRight;

  const CategoryCard({
    Key key,
    this.categoryName,
    this.isEmpty,
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
        child: InkWell(
          onTap: () {},
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isEmpty
                  ? [
                      Column(
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Text(
                            'Add Category',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ]
                  : [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                        child: Text(categoryName),
                      ),
                      Expanded(
                        child: Container(
                          height: 200,
                          color: Colors.green,
                        ),
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
    );
  }
}
