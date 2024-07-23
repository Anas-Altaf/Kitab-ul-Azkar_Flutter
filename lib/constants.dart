import 'package:flutter/material.dart';

const kApplicationName = 'Kitab ul Azkar';
const kAppVersion = '1.0.1';
const kMainColor = Color(0xFFF27E1C);
const kSelectedMenuItemColor = Color(0x1AF27E1C);
const kInputDialogButtonTextColor = TextStyle(
  color: kMainColor,
);
const kSuggestionTextColor = TextStyle(
  fontSize: 16,
  fontFamily: 'NotoNastaliq',
);
const kPageAnimationDuration = Duration(milliseconds: 500);
const kPageAnimationCurve = Curves.ease;
const kPrimaryBorderRadius = 10.0;
const kRoundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(kPrimaryBorderRadius),
    bottomRight: Radius.circular(kPrimaryBorderRadius),
  ),
);
final kMainThemeData = ThemeData(
  colorScheme: const ColorScheme.light(surface: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarTheme: const BottomAppBarTheme(
    shape: CircularNotchedRectangle(),
    color: kMainColor,
    shadowColor: Colors.black,
    surfaceTintColor: Colors.black,
    height: 10.0,
  ),
  appBarTheme: const AppBarTheme(
    //centerTitle: true,
    shape: kRoundedRectangleShape,

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
List<bool> kItemSelectionList = [
  false,
  false,
  false,
  false,
];
