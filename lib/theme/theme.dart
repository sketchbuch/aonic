import 'package:flutter/material.dart';

const colourHeadline = Color(0xff003300);
const colourOverlay = Color(0xffcce0c1);
const colourPaper = Color(0xffffffe6);
const colourPrimary = Color(0xff006633);
const colourPrimaryTint = Color(0xff004422);
const colourSplash = Color.fromARGB(32, 0, 51, 0);
const colourText = Color(0xff003300);

const themeProjectAon = ColorScheme(
  background: colourPaper,
  brightness: Brightness.light,
  error: colourText,
  onBackground: colourPrimary,
  onError: colourPaper,
  onPrimary: colourPaper,
  onSecondary: colourPaper,
  onSurface: colourPaper,
  primary: colourPrimary,
  secondary: colourPrimary,
  surface: colourPrimary,
  shadow: colourPrimary,
  surfaceTint: colourPrimaryTint,
);

ThemeData getTheme() {
  return ThemeData(
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => colourPrimary),
      overlayColor: MaterialStateColor.resolveWith((states) => colourOverlay),
    ),
    colorScheme: themeProjectAon,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: colourPaper,
        primary: colourPrimary,
      ),
    ),
    highlightColor: colourSplash,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => colourPrimary),
      overlayColor: MaterialStateColor.resolveWith((states) => colourOverlay),
    ),
    scaffoldBackgroundColor: colourPaper,
    shadowColor: colourPrimary,
    splashColor: colourSplash,
    textTheme: const TextTheme(
      headline1: TextStyle(color: colourHeadline, fontSize: 24, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: colourHeadline, fontSize: 20, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: colourHeadline, fontSize: 20, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: colourHeadline, fontSize: 20, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: colourHeadline, fontSize: 20, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: colourHeadline, fontSize: 20, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(color: colourPaper, fontSize: 16),
      bodyText2: TextStyle(color: colourText, fontSize: 16),
      button: TextStyle(color: colourPaper, fontSize: 16),
    ),
    unselectedWidgetColor: colourPrimary,
    useMaterial3: true,
  );
}
