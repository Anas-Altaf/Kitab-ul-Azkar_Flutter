import 'package:flutter/material.dart';

const kMainColor = Color(0xFFF27E1C);
const kPageAnimationDuration = Duration(milliseconds: 500);
const kPageAnimationCurve = Curves.ease;
const kPrimaryBorderRadius = 10.0;
const kAppVersion = '0.2.0';
final kMainThemeData = ThemeData(
  colorScheme: const ColorScheme.light(),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    //centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(kPrimaryBorderRadius),
        bottomRight: Radius.circular(kPrimaryBorderRadius),
      ),
    ),

    surfaceTintColor: Colors.black,
    shadowColor: Colors.black,
    color: kMainColor,
    // shadowColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
  ),
);
