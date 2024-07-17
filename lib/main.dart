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
      theme: kMainThemeData,
      home: const PdfViewWidget(),
    );
  }
}
