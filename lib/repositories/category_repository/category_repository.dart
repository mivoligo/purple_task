import 'package:hive/hive.dart';

import '../../entities/entities.dart';
import '../../globals/globals.dart' as g;
import '../../models/models.dart';
import '../repositories.dart';

class CategoryRepository extends BaseCategoryRepository {
  final box = Hive.box<CategoryEntity>(g.categoryBox);

  @override
  Future<Category> addCategory({required Category category}) async {
    await box.add(category.toEntity());
    return category;
  }

  @override
  Future<Category> updateCategory({required Category category}) async {
    final key =
        box.values.firstWhere((element) => element.id == category.id).key;
    await box.put(key, category.toEntity());
    return category;
  }

  @override
  Future<Category> deleteCategory({required Category category}) async {
    await box.values
        .firstWhere((element) => element.id == category.id)
        .delete();
    return category;
  }

  @override
  List<Category> getCategories() {
    return box.values.map((e) => Category.fromEntity(e)).toList();
  }
}
