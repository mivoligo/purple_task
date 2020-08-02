import 'package:to_do/local_db/interface/category_interface.dart';
import 'package:to_do/models/category.dart';

class HiveMethods implements CategoryInterface {
  @override
  init() {
    print('Initializing Hive');
    return null;
  }

  @override
  addCategory(Category category) {
    print('Adding category to Hive');
    return null;
  }

  @override
  deleteCategory(int categoryId) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  close() {
    // TODO: implement close
    throw UnimplementedError();
  }
}
