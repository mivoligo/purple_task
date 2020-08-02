import 'package:to_do/models/category.dart';

abstract class CategoryInterface {
  init();

  addCategory(Category category);

  /// returns a list of categories
  Future<List<Category>> getCategories();

  deleteCategory(int categoryId);

  close();
}
