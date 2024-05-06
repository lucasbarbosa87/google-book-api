import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      );
  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      );
}
