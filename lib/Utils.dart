import 'dart:ui';

class Utils {
  static double getFontSize(double size, Size sz) {
    if (sz.width == 320 && sz.height == 568) {
      return size - 2;
    } else {
      return size;
    }
  }
}
