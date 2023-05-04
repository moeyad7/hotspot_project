import 'package:flutter/material.dart';

lightThemeData(BuildContext context) {
  
  ColorScheme lightThemeColors(context) {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF58A07),
      onPrimary: Color(0xFFF58A07),
      secondary: Color(0xFF228CE5),
      onSecondary: Color(0xFF228CE5),
      tertiary: Color(0xFF2FC686),
      onTertiary: Color(0xFF2FC686),
      error: Color(0xFFF32424),
      onError: Color(0xFFF32424),
      background: Color(0xFFFDF1ED),
      onBackground: Color(0xFFFDF1ED),
      surface: Color(0x00000000),
      onSurface: Color(0x00000000),
    );
  }
}

darkThemeData(BuildContext context) {
  ColorScheme darkThemeColors(context) {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFF58A07),
      onPrimary: Color(0xFFF58A07),
      secondary: Color(0xFF228CE5),
      onSecondary: Color(0xFF228CE5),
      tertiary: Color(0xFF2FC686),
      onTertiary: Color(0xFF2FC686),
      error: Color(0xFFF32424),
      onError: Color(0xFFF32424),
      background: Color(0xFFFDF1ED),
      onBackground: Color(0xFFFDF1ED),
      surface: Color(0x00000000),
      onSurface: Color(0x00000000),
    );
  }
}
