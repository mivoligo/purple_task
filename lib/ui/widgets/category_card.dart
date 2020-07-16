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
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 16.0, paddingRight, 32.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          child: Column(
            children: isEmpty
                ? [
                    Text('+'),
                    Text('Add Category'),
                  ]
                : [
                    Text(categoryName),
                    Container(
                      height: 200,
                      color: Colors.green,
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Text('Add Task'),
                  ],
          ),
        ),
      ),
    );
  }
}
