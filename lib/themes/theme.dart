import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:depannagexpress/utils/colors.dart';

class CustomTheme {
  static const lightThemeFont = "ComicNeue", darkThemeFont = "Poppins";

  // light theme
  static final lightTheme = ThemeData(
    primaryColor: lightThemeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    useMaterial3: true,
    fontFamily: lightThemeFont,
    switchTheme: SwitchThemeData(
      thumbColor:
      MaterialStateProperty.resolveWith<Color>((states) => lightThemeColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: pink,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: white,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: lightThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: lightThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: darkThemeColor,
    brightness: Brightness.dark,
    //scaffoldBackgroundColor: black,
    scaffoldBackgroundColor: Colors.black54,
    useMaterial3: true,
    fontFamily: darkThemeFont,
    switchTheme: SwitchThemeData(
      trackColor:
      MaterialStateProperty.resolveWith<Color>((states) => darkThemeColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      //backgroundColor: black,
      backgroundColor: pink,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: white,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: darkThemeColor),
      elevation: 2,
      actionsIconTheme: IconThemeData(color: darkThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme().copyWith(
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            //color: Colors.pink
            color: Colors.white
        )
    ),

  );

  // colors
  static Color lightThemeColor = Colors.red,
      white = Colors.white,
      black = Colors.black,
      //darkThemeColor = Colors.yellow;
      darkThemeColor = white;
}