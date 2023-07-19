import 'package:flutter/material.dart';

extension context on BuildContext {
  static const int _largeWidth = 1366;
  static const int _mediumWidth = 768;
  bool get screenIsLarge => MediaQuery.of(this).size.width >= _largeWidth;
  bool get screenIsMedium =>
      MediaQuery.of(this).size.width >= _mediumWidth && !screenIsLarge;
  bool get screenIsSmall => MediaQuery.of(this).size.width < _mediumWidth;

  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  TextTheme get textTheme => Theme.of(this).textTheme;

  void update() => (this as Element).markNeedsBuild();
}
