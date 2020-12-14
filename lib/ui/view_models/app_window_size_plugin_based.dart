import 'dart:ui';

import 'package:window_size/window_size.dart' as window_size;

import '../ui.dart';

class AppWindowSizePluginBased implements AppWindowSize {
  final double appWidth;
  final double appHeight;

  AppWindowSizePluginBased({
    this.appWidth: 500,
    this.appHeight: 700,
  });

  @override
  saveWindowSize() {
    // TODO: implement getWindowSize
    throw UnimplementedError();
  }

  @override
  setWindowSize() {
    window_size.getWindowInfo().then((window) {
      final screen = window.screen;
      if (screen != null) {
        final screenFrame = screen.visibleFrame;
        final left = ((screenFrame.width - appWidth) / 2).roundToDouble();
        final top = ((screenFrame.height - appHeight) / 3).roundToDouble();
        final frame = Rect.fromLTWH(left, top, appWidth, appHeight);
        window_size.setWindowFrame(frame);
      }
    });
  }
}
