import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/pdf_view_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
      ),
      home: const PdfViewWidget(),
    );
  }
}
