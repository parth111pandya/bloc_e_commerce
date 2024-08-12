import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.yellow,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFFEBEBEB),
  fontFamily: "RobotoSlab-Regular",
);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF3D3D3D),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
  ),
  useMaterial3: true,
  fontFamily: "RobotoSlab-Regular",
);
