import 'package:flutter/widgets.dart';

class Responsive {
  static double _screenWidth = 375;
  static double _screenHeight = 849;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  static double sizeW(double size) {
    const double baselineWidth = 375;
    return size * (_screenWidth / baselineWidth);
  }

  static double sizeH(double size) {
    const double baselineHeight = 849;
    return size * (_screenHeight / baselineHeight);
  }
}