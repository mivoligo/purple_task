import 'package:hive/hive.dart';
import '../../constants/constants.dart';
import 'models.dart';

class AppWindowSizePluginBased implements AppWindowSize {
  double _appWidth = 500.0;
  double _appHeight = 700.0;

  @override
  void saveWindowSize(double width, double height) {
    final box = Hive.box(settingsBox);
    box.put(appWidthKey, width);
    box.put(appHeightKey, height);
  }

  @override
  void setWindowSize() {
    final box = Hive.box(settingsBox);
    _appWidth = box.get(appWidthKey, defaultValue: 500.0);
    _appHeight = box.get(appHeightKey, defaultValue: 700.0);
    // todo: handle window size setting
  }
}
