import 'package:hive/hive.dart';
import '../../db_models/category.dart';
import '../../globals/hive_names.dart';

class CategoryRepository {
  Box<Category> box = Hive.box<Category>(categoryBox);

  void addCategory(Category category) {
    box.add(category);
  }

  void updateCategory(int index, Category category) {
    box.putAt(index, category);
  }

  void deleteCategory(int index) {
    box.deleteAt(index);
  }

  List<Category> getCategories() {
    return box.values.toList();
  }
}
