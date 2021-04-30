import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class CategoryViewModel extends ChangeNotifier {
  final categoryRepository =
      ProviderContainer().read(categoryRepositoryProvider);

  void addCategory(Category category) {
    categoryRepository.addCategory(category: category);

    notifyListeners();
  }

  List<Category> getListOfCategories() {
    return categoryRepository.getCategories();
  }

  void updateCategory(int index, Category category) {
    categoryRepository.updateCategory(category: category);
    notifyListeners();
  }

  void deleteCategory(Category category) {
    categoryRepository.deleteCategory(category: category);

    notifyListeners();
  }

  Category? _currentCategory;

  Category? get currentCategory => _currentCategory;

  set currentCategory(Category? category) {
    _currentCategory = category;
    notifyListeners();
  }

  late Color _color;

  Color get color => _color;

  set color(Color value) {
    _color = value;
    notifyListeners();
  }

  int _icon = AntIcons.folder.codePoint;

  int get icon => _icon;

  set icon(int value) {
    _icon = value;
    notifyListeners();
  }
}
