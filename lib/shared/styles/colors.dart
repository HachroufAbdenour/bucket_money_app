import 'package:flutter/material.dart';

class AppColors {
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color green = Colors.green;
  static const Color red = Color(0xFFFF0000);
    static const Color darkGray = Color(0xFF333333); // Define dark mode background color
  static const Color darkCard = Color(0xFF555555);
 
 // static const MaterialColor primary = MaterialColor(0xFFC0028B, primaryMaterial);
 
   static const MaterialColor primary = MaterialColor(0xFF1F9DEC, primaryMaterial);


  static const Color primaryLight = Color(0xFFF9E6F3);
  static const Color lightGray = Color(0xFFF7F7F7);
  static const Color blackBackground = Color(0xFF18191A);
  static const Color blackCard = Color(0xFF242526);
  static const Color grayHover = Color(0xFF3A3B3C);
  static const Color darkPrimary = Color(0xFFE4E6EB);
  static const Color darkSecondary = Color(0xFFB0B3B8);

  static const Map<int, Color> primaryMaterial = <int, Color>{
      50: Color.fromRGBO(31, 157, 236, 0.1),
    100: Color.fromRGBO(31, 157, 236, 0.2),
    200: Color.fromRGBO(31, 157, 236, 0.3),
    300: Color.fromRGBO(31, 157, 236, 0.4),
    400: Color.fromRGBO(31, 157, 236, 0.5),
    500: Color.fromRGBO(31, 157, 236, 0.6),
    600: Color.fromRGBO(31, 157, 236, 0.7),
    700: Color.fromRGBO(31, 157, 236, 0.8),
    800: Color.fromRGBO(31, 157, 236, 0.9),
    900: Color.fromRGBO(31, 157, 236, 1),
  };
}
