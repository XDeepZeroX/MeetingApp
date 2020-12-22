import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData appThemeLight = ThemeData(
    // brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.green[800],
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.green[900]),
      // hintStyle: TextStyle(color: Colors.red),
      // border: InputDecoration(),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[900]),
          borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
  );

  static ThemeData appThemeDark = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.green),
      // hintStyle: TextStyle(color: Colors.red),
      // border: InputDecoration(),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
    // textButtonTheme: TextButtonThemeData(
    //     style: ButtonStyle(
    //   foregroundColor: Colors.white,
    // )),
    primaryColorBrightness: Brightness.dark,
    canvasColor: Color.fromRGBO(26, 26, 26, 1),
    appBarTheme: AppBarTheme(
      color: Colors.black,
    ),
    // accentColor: Colors.purple
    // floatingActionButtonTheme:
    //     FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  );
}

extension CustomColorScheme on ColorScheme {
  /// Цвет по умолчанию
  Color get defaultColor => brightness == Brightness.light
      ? const Color.fromRGBO(0, 0, 0, 1)
      : const Color.fromRGBO(255, 255, 255, 1);

  /// Цвет по умолчанию инвертированный
  Color get defaultReverseColor => brightness != Brightness.light
      ? const Color.fromRGBO(0, 0, 0, 1)
      : const Color.fromRGBO(255, 255, 255, 1);

  ///Цвет текущего дня на календаре
  Color get todayButtonColor =>
      isDark ? const Color.fromRGBO(255, 255, 255, 0.1) : Colors.green[100];

  ///Цвет выбранного дня на календаре
  Color get selectedDayButtonColor =>
      isDark ? const Color.fromRGBO(255, 255, 255, 0.7) : Colors.green[300];

  ///Цвет плавающей кнопки
  Color get floatingActionButton => isDark ? Colors.white : Colors.green[800];

  ///Флаг темной темы
  bool get isDark => brightness == Brightness.dark;

  ///Кнопки
  Color get success =>  const Color(0xFF28a745);
  Color get info => const Color(0xFF17a2b8);
  Color get warning => const Color(0xFFffc107);
  Color get danger => const Color(0xFFdc3545);
  Color get cancel => const Color(0xFF808080);
}
