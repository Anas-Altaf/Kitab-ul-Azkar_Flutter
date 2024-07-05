import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MainApp());
}

const Color mainColor = Color.fromRGBO(253, 124, 33, 1.0);

class MainApp extends StatelessWidget {
  const MainApp({super.key});
//Some Vars
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
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/k2.pdf'),
  );
  final TextEditingController _pageController = TextEditingController();
  void _showErrorDialog(String message) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Error",
      desc: "$message",
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

  int pagesCount = 0;
  int currentPage = 0;
  pageLoader(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
      currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    int pagesCount = pdfController.pagesCount ?? 0;
    pagesCount--;
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
              '$currentPage/${pagesCount ?? 0}',
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
              onPageChanged: (pageNumber) {
                pageLoader(pageNumber);
              },
              reverse: true,
              pageSnapping: false,
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
                    pdfController.jumpToPage(6);
                  },
                  icon: const Icon(Icons.home_filled),
                ),
                ElevatedButton.icon(
                  onLongPress: () {
                    if (currentPage >= 0) {
                      pdfController.jumpToPage(currentPage + 11);
                    } else {
                      pdfController.jumpToPage(0);
                    }
                  },
                  onPressed: () {
                    if (currentPage >= 0) {
                      pdfController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      pdfController.jumpToPage(0);
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
                    if (currentPage >= 0) {
                      pdfController.jumpToPage(currentPage - 9);
                    } else {
                      pdfController.jumpToPage(0);
                    }
                  },
                  onPressed: () {
                    if (currentPage > 0) {
                      pdfController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      pdfController.jumpToPage(0);
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
                      pageEntered++;
                      if (input.isNotEmpty &&
                          pageEntered >= 0 &&
                          pageEntered <= pagesCount + 1) {
                        pdfController.jumpToPage(pageEntered);
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
}
