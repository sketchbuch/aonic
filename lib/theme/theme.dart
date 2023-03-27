import 'package:flutter/material.dart';

const colourHeadline = Color(0xff003300);
const colourOverlay = Color(0xffcce0c1);
const colourPaper = Color(0xffffffe6);
const colourPrimary = Color(0xff006633);
const colourPrimaryTint = Color(0xff004422);
const colourSecondary = Color.fromARGB(255, 88, 150, 119);
const colourSplash = Color.fromARGB(32, 0, 51, 0);
const colourText = Color(0xff003300);
const colourBorder = Color(0x55003300);
const colourWhite = Color(0xffffffff);

const fontSizeS = 14.0;
const fontSizeM = 16.0;
const fontSizeL = 20.0;
const fontSizeXl = 24.0;

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
    inputDecorationTheme: const InputDecorationTheme(
      helperStyle: TextStyle(fontSize: fontSizeS),
      hintStyle: TextStyle(color: colourText, fontSize: fontSizeM),
      labelStyle: TextStyle(color: colourText, fontSize: fontSizeM),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => colourPrimary),
      overlayColor: MaterialStateColor.resolveWith((states) => colourOverlay),
    ),
    scaffoldBackgroundColor: colourPaper,
    shadowColor: colourPrimary,
    splashColor: colourSplash,
    textTheme: const TextTheme(
      headline1: TextStyle(color: colourHeadline, fontSize: fontSizeXl, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: colourHeadline, fontSize: fontSizeL, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: colourHeadline, fontSize: fontSizeL, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: colourHeadline, fontSize: fontSizeL, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: colourHeadline, fontSize: fontSizeL, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: colourHeadline, fontSize: fontSizeL, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
        color: colourPaper,
        fontSize: fontSizeM,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      bodyText2: TextStyle(
        color: colourText,
        fontSize: fontSizeM,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      subtitle1: TextStyle(color: colourText, fontSize: fontSizeM),
      subtitle2: TextStyle(color: colourText, fontSize: fontSizeS),
      button: TextStyle(color: colourPaper, fontSize: fontSizeM),
    ),
    unselectedWidgetColor: colourPrimary,
    useMaterial3: true,
  );
}
