import 'package:flutter/material.dart';

class Palette {
  static Color get primary => const Color(0xFF364F6B);
  static Color get danger => const Color(0xFFFC5185);
  static Color get ok => const Color(0xFF3FC1C9);
  static Color get secondary => const Color(0xFFF5F5F5);

  static const MaterialColor kToDark = MaterialColor(
    0xff364f6b, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff4a617a), //10%
      100: Color(0xff5e7289), //20%
      200: Color(0xff728497), //30%
      300: Color(0xff8695a6), //40%
      400: Color(0xff9ba7b5), //50%
      500: Color(0xffafb9c4), //60%
      600: Color(0xffc3cad3), //70%
      700: Color(0xffd7dce1), //80%
      800: Color(0xffebedf0), //90%
      900: Color(0xffffffff), //100%
    },
  );
}
