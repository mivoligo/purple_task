import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:window_size/window_size.dart' as window_size;
import '../../globals/globals.dart';
import '../ui.dart';

class AppWindowSizePluginBased implements AppWindowSize {
  double? _appWidth;
  double? _appHeight;

  @override
  saveWindowSize(double width, double height) {
    saveAppSizeToHive(width, height);
  }

  @override
  setWindowSize() {
    getAppSize();
    window_size.getWindowInfo().then((window) {
      final screen = window.screen;
      if (screen != null) {
        final screenFrame = screen.visibleFrame;
        final left = ((screenFrame.width - _appWidth!) / 2).roundToDouble();
        final top = ((screenFrame.height - _appHeight!) / 3).roundToDouble();
        final frame = Rect.fromLTWH(left, top, _appWidth!, _appHeight!);
        window_size.setWindowFrame(frame);
      }
    });
  }

  void getAppSize() {
    final box = Hive.box(SETTINGS_BOX);
    _appWidth = box.get(APP_WIDTH_KEY, defaultValue: 500.0);
    _appHeight = box.get(APP_HEIGHT_KEY, defaultValue: 700.0);
  }

  void saveAppSizeToHive(double width, double height) {
    final box = Hive.box(SETTINGS_BOX);
    box.put(APP_WIDTH_KEY, width);
    box.put(APP_HEIGHT_KEY, height);
  }
}
