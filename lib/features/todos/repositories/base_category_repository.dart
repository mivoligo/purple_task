import 'package:purple_task/features/todos/models/category.dart';

abstract class BaseCategoryRepository {
  Future<int> add({required Category category});

  Future<void> update({required Category category});

  Future<void> remove({required int categoryId});

  Future<void> reorder({required List<Category> categories});

  Future<List<Category>> getCategories();
}
