import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final bool isEmpty;
  final String categoryName;

  const CategoryCard({Key key, this.categoryName, this.isEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  color: Colors.blue,
                ),
                Divider(
                  thickness: 2.0,
                ),
                Text('Add Task'),
              ],
      ),
    );
  }
}
