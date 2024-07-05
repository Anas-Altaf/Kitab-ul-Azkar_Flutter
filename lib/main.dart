import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MainApp());
}

const Color mainColor = Color.fromRGBO(253, 124, 33, 1.0);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfViewWidget(),
    );
  }
}

class PdfViewWidget extends StatefulWidget {
  const PdfViewWidget({super.key});

  @override
  State<PdfViewWidget> createState() => _PdfViewWidgetState();
}

class _PdfViewWidgetState extends State<PdfViewWidget> {
  late PdfController pdfController;
  final TextEditingController _pageController = TextEditingController();
  int currentPage = 0;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/k2.pdf'),
    );
    _initPdf();
  }

  Future<void> _initPdf() async {
    final document = await pdfController.document;
    totalPages = document.pagesCount;
    totalPages--;
    setState(() {});
  }

  void _showErrorDialog(String message) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Error",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 100,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                'Kitab ul Azkar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$currentPage/$totalPages',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfView(
              controller: pdfController,
              scrollDirection: Axis.horizontal,
              reverse: true,
              onPageChanged: (page) {
                setState(() {
                  currentPage = --page;
                });
              },
              builders: PdfViewBuilders<DefaultBuilderOptions>(
                options: const DefaultBuilderOptions(),
                documentLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                pageLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                errorBuilder: (_, error) =>
                    Center(child: Text(error.toString())),
              ),
            ),
          ),
          Container(
            color: mainColor,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 15),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    pdfController.jumpToPage(1);
                  },
                  icon: const Icon(Icons.home_filled),
                ),
                ElevatedButton.icon(
                  onLongPress: () {
                    if (currentPage >= 0) {
                      pdfController.jumpToPage(currentPage + 10);
                    } else {
                      pdfController.jumpToPage(1);
                    }
                  },
                  onPressed: () {
                    if (currentPage < totalPages) {
                      pdfController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      _showErrorDialog('No more pages');
                    }
                  },
                  label: Text(
                    'Next Page',
                    style: TextStyle(
                      color: mainColor,
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_back,
                    color: mainColor,
                  ),
                ),
                ElevatedButton.icon(
                  onLongPress: () {
                    if (currentPage > 0) {
                      pdfController.jumpToPage(currentPage - 10);
                    } else {
                      pdfController.jumpToPage(1);
                    }
                  },
                  onPressed: () {
                    if (currentPage >= 1) {
                      pdfController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      _showErrorDialog('No more pages!');
                    }
                  },
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    'Previous Page',
                    style: TextStyle(color: mainColor),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: mainColor,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    controller: _pageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Page',
                    ),
                    onSubmitted: (String input) {
                      input = input.trim();
                      int pageEntered = int.tryParse(input) ?? 0;
                      if (input.isNotEmpty &&
                          pageEntered >= 0 &&
                          pageEntered <= totalPages) {
                        pdfController.jumpToPage(++pageEntered);
                      } else {
                        _showErrorDialog('Invalid Page');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }
}
