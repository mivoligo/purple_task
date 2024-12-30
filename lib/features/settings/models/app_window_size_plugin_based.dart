import 'package:purple_task/features/settings/models/models.dart';

class AppWindowSizePluginBased implements AppWindowSize {
  final double _appWidth = 500;
  final double _appHeight = 700;

  @override
  void saveWindowSize(double width, double height) {
    // final box = Hive.box(settingsBox);
    // box.put(appWidthKey, width);
    // box.put(appHeightKey, height);
  }

  @override
  void setWindowSize() {
    // final box = Hive.box(settingsBox);
    // _appWidth = box.get(appWidthKey, defaultValue: 500.0);
    // _appHeight = box.get(appHeightKey, defaultValue: 700.0);
    // TODO(m): handle window size setting
  }
}
