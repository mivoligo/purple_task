import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:window_size/window_size.dart' as window_size;
import '../../globals/globals.dart';
import '../view_models/view_models.dart';

class AppWindowSizePluginBased implements AppWindowSize {
  double _appWidth = 500.0;
  double _appHeight = 700.0;

  @override
  void saveWindowSize(double width, double height) {
    saveAppSizeToHive(width, height);
  }

  @override
  void setWindowSize() {
    getAppSize();
    window_size.getWindowInfo().then((window) {
      final screen = window.screen;
      if (screen != null) {
        final screenFrame = screen.visibleFrame;
        final left = ((screenFrame.width - _appWidth) / 2).roundToDouble();
        final top = ((screenFrame.height - _appHeight) / 3).roundToDouble();
        final frame = Rect.fromLTWH(left, top, _appWidth, _appHeight);
        window_size.setWindowFrame(frame);
      }
    });
  }

  void getAppSize() {
    final box = Hive.box(settingsBox);
    _appWidth = box.get(appWidthKey, defaultValue: 500.0);
    _appHeight = box.get(appHeightKey, defaultValue: 700.0);
  }

  void saveAppSizeToHive(double width, double height) {
    final box = Hive.box(settingsBox);
    box.put(appWidthKey, width);
    box.put(appHeightKey, height);
  }
}
