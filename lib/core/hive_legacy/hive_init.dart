import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:purple_task/core/constants/hive_names.dart';
import 'package:purple_task/core/hive_legacy/hive_entities/category_entity.dart';
import 'package:purple_task/core/hive_legacy/hive_entities/task_entity.dart';

class HiveInit {
  Future<void> initHive() async {
    final dir = await path_provider.getApplicationSupportDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(CategoryEntityAdapter())
      ..registerAdapter(TaskEntityAdapter());

    if (await Hive.boxExists(settingsBox)) {
      await Hive.openBox<dynamic>(settingsBox);
    }
    if (await Hive.boxExists(categoryBox)) {
      await Hive.openBox<CategoryEntity>(categoryBox);
    }
    if (await Hive.boxExists(taskBox)) {
      await Hive.openBox<TaskEntity>(taskBox);
    }
  }
}
