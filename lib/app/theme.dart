import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrandColors {
  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: light,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // SystemUiOverlayStyle(
      //   statusBarBrightness: Brightness.light,
      //   statusBarIconBrightness: Brightness.dark,
      // ),
      foregroundColor: dark,
      iconTheme: IconThemeData(color: dark),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(4, 26, 82, 1),
      ),
    ),
    fontFamily: 'FiraSans',
  );

  static const Map<int, Color> primarySwatch = {
    50: Color.fromRGBO(250, 90, 0, 0.1),
    100: Color.fromRGBO(250, 90, 0, 0.2),
    200: Color.fromRGBO(250, 90, 0, 0.3),
    300: Color.fromRGBO(250, 90, 0, 0.4),
    400: Color.fromRGBO(250, 90, 0, 0.5),
    500: Color.fromRGBO(250, 90, 0, 0.6),
    600: Color.fromRGBO(250, 90, 0, 0.7),
    700: Color.fromRGBO(250, 90, 0, 0.8),
    800: Color.fromRGBO(250, 90, 0, 0.9),
    900: Color.fromRGBO(250, 90, 0, 1),
  };

  static const Color primary = Color.fromRGBO(250, 90, 0, 1);
  static const Color info = Color.fromRGBO(23, 89, 241, 1);
  static const Color success = Color.fromRGBO(250, 90, 0, 1);
  static const Color danger = Color.fromRGBO(184, 9, 9, 1);
  static const Color warning = Color.fromRGBO(255, 8, 8, 1);
  static const Color dark = Color.fromRGBO(0, 0, 0, 1);
  static const Color light = Color.fromRGBO(244, 244, 244, 1);

  static const Color grayDarker = Color.fromRGBO(34, 34, 34, 1); // 13.5%
  static const Color grayDark = Color.fromRGBO(51, 51, 51, 1); // 20%
  static const Color gray = Color.fromRGBO(85, 85, 85, 1); // 33.5%
  static const Color grayLight = Color.fromRGBO(119, 119, 119, 1); // 46.7%
  static const Color grayLighter = Color.fromRGBO(238, 238, 238, 1); // 93.5%

  static const Color facebook = Color.fromRGBO(59, 89, 152, 1);
}
