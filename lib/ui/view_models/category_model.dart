import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;

  Category({
    this.name,
    this.color,
    this.icon,
  });
}

class CategoryList extends ChangeNotifier {
  List<Category> categoryList = [
    Category(name: 'Home', color: Colors.blue, icon: Icons.home),
    Category(name: 'Work', color: Colors.amber, icon: Icons.work),
    Category(name: 'Other', color: Colors.green, icon: Icons.note),
    Category(name: 'Other one', color: Colors.grey, icon: Icons.nature),
  ];

  void addCategory() {
    Category category =
        Category(name: 'Category ${categoryList.length}', color: Colors.purple);
    categoryList.add(category);
    notifyListeners();
  }
}
