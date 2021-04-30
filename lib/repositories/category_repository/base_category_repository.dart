import '../../models/models.dart';

abstract class BaseCategoryRepository {
  Future<Category> addCategory({required Category category});

  Future<Category> updateCategory({required Category category});

  Future<Category> deleteCategory({required Category category});

  List<Category> getCategories();
}
