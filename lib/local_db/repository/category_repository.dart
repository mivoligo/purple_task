import 'package:meta/meta.dart';
import 'package:to_do/local_db/db/hive_methods.dart';
import 'package:to_do/local_db/db/sqlite_methods.dart';
import 'package:to_do/models/category.dart';

class CategoryRepository {
  static var dbObject;
  static bool isHive;

  static init({@required bool isHive}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.init();
  }

  static addCategory(Category category) => dbObject.addCategory(category);

  static deleteCategory(int id) => dbObject.deleteCategory(id);

  static getCategories() => dbObject.getCategories();

  static close() => dbObject.close();
}
