import 'package:hive/hive.dart';

import '../../constants/constants.dart';
import '../../entities/entities.dart';
import '../../models/models.dart';
import '../repositories.dart';

class CategoryRepository extends BaseCategoryRepository {
  final _box = Hive.box<CategoryEntity>(categoryBox);

  @override
  Future<Category> add({required Category category}) async {
    await _box.add(category.toEntity());
    return category;
  }

  @override
  Future<Category> update({required Category category}) async {
    final key =
        _box.values.firstWhere((element) => element.id == category.id).key;
    await _box.put(key, category.toEntity());
    return category;
  }

  @override
  Future<Category> remove({required Category category}) async {
    await _box.values
        .firstWhere((element) => element.id == category.id)
        .delete();
    return category;
  }

  @override
  List<Category> getCategories() {
    return _box.values.map(Category.fromEntity).toList();
  }
}
