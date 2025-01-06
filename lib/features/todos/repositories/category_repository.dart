import 'package:hive/hive.dart';

import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/features/todos/models/category.dart';
import 'package:purple_task/features/todos/models/category_entity.dart';
import 'package:purple_task/features/todos/repositories/base_category_repository.dart';

class CategoryRepository extends BaseCategoryRepository {
  final _categoryBox = Hive.box<CategoryEntity>(categoryBox);
  // final _categoriesOrderBox = Hive.box<List<String>>(categoriesListOrderBox);

  @override
  Future<int> add({required Category category}) async {
    await _categoryBox.add(category.toEntity());
    // final categoryListOrder = _categoriesOrderBox.get(categoriesListOrderKey);
    // categoryListOrder?.add(category.id.toString());
    return category.id;
  }

  @override
  Future<Category> update({required Category category}) async {
    final key = _categoryBox.values
        .firstWhere((element) => element.id == category.id)
        .key;
    await _categoryBox.put(key, category.toEntity());
    return category;
  }

  @override
  Future<void> remove({required int categoryId}) async {
    // _categoriesOrderBox
    //     .get(categoriesListOrderKey)
    //     ?.remove(category.id.toString());
    await _categoryBox.values
        .firstWhere((element) => element.id == categoryId)
        .delete();
  }

  @override
  Future<List<Category>> getCategories() {
    // final categoriesOrder = _categoriesOrderBox.get(categoriesListOrderKey);

    // if (categoriesOrder == null || categoriesOrder.isEmpty) {
    //   _categoriesOrderBox.put(
    //     categoriesListOrderKey,
    //     _categoryBox.values.map((e) => e.id.toString()).toList(),
    //   );
    // }

    return Future.value(_categoryBox.values.map(Category.fromEntity).toList());
    // ..sort(
    //   (a, b) {
    //     final order = _categoriesOrderBox.get(categoriesListOrderKey);
    //
    //     if (order == null) {
    //       return a.id.compareTo(b.id);
    //     }
    //
    //     return order
    //         .indexOf(a.id.toString())
    //         .compareTo(order.indexOf(b.id.toString()));
    //   },
    // );
  }

  @override
  Future<void> reorder({required List<Category> categories}) async {
    // final categoriesOrder =
    //     _categoriesOrderBox.get(categoriesListOrderKey, defaultValue: []);

    // if (oldIndex < newIndex) {
    //   newIndex -= 1;
    // }

    // final item = categoriesOrder!.removeAt(oldIndex);
    // categoriesOrder.insert(newIndex, item);
    //
    // _categoriesOrderBox.put(categoriesListOrderKey, categoriesOrder);
  }
}
