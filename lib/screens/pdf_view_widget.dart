import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../assets_path/imagePaths.dart';
import '../components/url_opener.dart';
import '../constants.dart';

class PdfViewWidget extends StatefulWidget {
  const PdfViewWidget({super.key});

  @override
  State<PdfViewWidget> createState() => _PdfViewWidgetState();
}

class _PdfViewWidgetState extends State<PdfViewWidget> {
  //getting App Info
  Future<void> versionFinder() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    setState(() => _version = version);
  }

  //Other Vars
  late List<String> pdfImages;
  late PageController _pageController;
  imagePaths imagePath = imagePaths();
  final TextEditingController _pageTextController = TextEditingController();
  int currentPage = 0;
  late int totalPages = pdfImages.length;
  int loadedPage = 0;
  late String _version = kAppVersion;
  @override
  void initState() {
    super.initState();
    pdfImages = imagePath.getImages();
    _pageController = PageController(initialPage: 0);
  }

  void updatePage() {
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Error",
      desc: message,
      buttons: [
        DialogButton(
          width: 100,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitab ul Azkar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              '$currentPage/$totalPages',
              style: const TextStyle(fontSize: 17),
            ),
          ),
          IconButton(
            onPressed: () {
              versionFinder();
              showAboutDialog(
                context: context,
                applicationName: 'Kitab ul Azkar',
                applicationVersion: _version,
                applicationIcon: const Icon(Icons.book_outlined),
                applicationLegalese:
                    'This application was developed by\nCodeCop.\n Developer: Anas Altaf',
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              launchURL(
                                  urlString: 'https://github.com/Anas-Altaf');
                            },
                            icon: const Icon(FontAwesomeIcons.github),
                          ),
                          IconButton(
                            onPressed: () {
                              launchURL(
                                  urlString: 'https://youtube.com/@azlafix');
                            },
                            icon: const Icon(FontAwesomeIcons.youtube),
                          ),
                          IconButton(
                            onPressed: () {
                              launchURL(
                                  urlString: 'https://wa.me/923104889407');
                            },
                            icon: const Icon(FontAwesomeIcons.whatsapp),
                          ),
                          IconButton(
                            onPressed: () {
                              launchURL(urlString: 'https://facebook.com/');
                            },
                            icon: const Icon(FontAwesomeIcons.facebook),
                          ),
                          IconButton(
                            onPressed: () {
                              launchURL(
                                  urlString: 'mailto:anasaltaf35@gmail.com');
                            },
                            icon: const Icon(FontAwesomeIcons.envelope),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            _pageController.jumpToPage(5);
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              onPageChanged: (index) {
                currentPage = index;
                updatePage();
              },
              allowImplicitScrolling: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padEnds: false,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: pdfImages.length,
              // itemBuilder: (context, index) {
              //   currentPage = index;
              //   totalPages = pdfImages.length;
              //
              //   // print(_currentPage??0);
              //   // print(totalPages??0);
              //   return Image.asset(
              //     pdfImages[index],
              //   );
              // },
              itemBuilder: (context, index) {
                return AnimatedSwitcher(
                  duration: kPageAnimationDuration,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      kPrimaryBorderRadius,
                    ),
                    child: Image.asset(
                      pdfImages[index],
                      key: ValueKey<int>(index),
                    ),
                  ),
                );
              },
              reverse: true,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kPrimaryBorderRadius),
                  topRight: Radius.circular(kPrimaryBorderRadius),
                ),
                color: kMainColor,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onLongPress: () {
                      if (currentPage >= 0) {
                        _pageController.jumpToPage(currentPage + 10);
                      } else {
                        _pageController.jumpToPage(1);
                      }
                    },
                    onPressed: () {
                      if (currentPage <= totalPages) {
                        _pageController.nextPage(
                          duration: kPageAnimationDuration,
                          curve: kPageAnimationCurve,
                        );
                      } else {
                        _showErrorDialog('No more pages');
                      }
                    },
                    label: const Text(
                      'Next Page',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kMainColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onLongPress: () {
                      if (currentPage >= 0) {
                        _pageController.jumpToPage(currentPage - 10);
                      } else {
                        _pageController.jumpToPage(1);
                      }
                    },
                    onPressed: () {
                      if (currentPage >= 0) {
                        _pageController.previousPage(
                          duration: kPageAnimationDuration,
                          curve: kPageAnimationCurve,
                        );
                      } else {
                        _showErrorDialog('No more pages!');
                      }
                    },
                    iconAlignment: IconAlignment.end,
                    label: const Text(
                      'Prev. Page',
                      style: TextStyle(color: kMainColor),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: kMainColor,
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _pageTextController,
                      cursorColor: kMainColor,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '🔎Page',
                      ),
                      onSubmitted: (String input) {
                        input = input.trim();
                        int pageEntered = int.tryParse(input) ?? 0;
                        if (input.isNotEmpty &&
                            pageEntered >= 0 &&
                            pageEntered <= totalPages) {
                          _pageController.jumpToPage(pageEntered);
                        } else {
                          _showErrorDialog('Invalid Page');
                        }
                        _pageTextController.clear();
                        _pageTextController.clearComposing();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
