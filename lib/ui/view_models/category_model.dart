import 'package:flutter/material.dart';

class Category extends ChangeNotifier {
  final String name;
  final Color color;

  Category({this.name, this.color});
}

class CategoryList extends ChangeNotifier {
  List<Category> categoryList = [
    Category(name: 'Home', color: Colors.blue),
    Category(name: 'Work', color: Colors.amber),
    Category(name: 'Other', color: Colors.green),
    Category(name: 'Other one', color: Colors.grey),
  ];

  void addCategory() {
    Category category =
        Category(name: 'Category ${categoryList.length}', color: Colors.purple);
    categoryList.add(category);
    notifyListeners();
  }
}
