import 'package:flutter/material.dart';
import 'package:kitabulazkar/screens/azkar_list.dart';

import '../assets_path/imagePaths.dart';
import '../components/menu_bar.dart';
import '../components/toast_message.dart';
import '../constants.dart';

class PdfViewWidget extends StatefulWidget {
  const PdfViewWidget({super.key});

  @override
  State<PdfViewWidget> createState() => _PdfViewWidgetState();
}

class _PdfViewWidgetState extends State<PdfViewWidget> {
  //Other Vars
  late List<String> pdfImages;
  late PageController _pageController;
  imagePaths imagePath = imagePaths();
  int currentPage = 0;
  late int totalPages = pdfImages.length;
  int loadedPage = 0;
  @override
  void initState() {
    super.initState();
    pdfImages = imagePath.getImages();
    _pageController = PageController(initialPage: 1);
    ToastUtil.init(context);
  }

  void updatePage() {
    setState(() {});
  }

  void jumpToPageByNumber(int pageNumber) {
    pageNumber >= 0 && pageNumber < totalPages
        ? _pageController.jumpToPage(pageNumber)
        : pageNumber == -1
            ? ToastUtil.showErrorToast('No Action')
            : ToastUtil.showErrorToast('Invalid Page');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(kApplicationName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              top: 3.0,
            ),
            child: Text(
              '$currentPage/${totalPages - 1}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                int selectedPage = -1;
                try {
                  selectedPage = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const AzkarListScreen();
                  }));
                } catch (e) {
                  // print(e);
                }
                jumpToPageByNumber(selectedPage);
              },
              icon: const Icon(
                Icons.manage_search_outlined,
                size: 25,
              ),
            ),
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () async {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: SafeArea(
        child: NavDrawer(
          onResult: (selectedPage) {
            jumpToPageByNumber(selectedPage);
            //print('pdf View Widget Page : $selectedPage');
          },
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
                      jumpToPageByNumber(currentPage + 10);
                    },
                    onPressed: () {
                      _pageController.nextPage(
                        duration: kPageAnimationDuration,
                        curve: kPageAnimationCurve,
                      );
                    },
                    label: const Text(
                      'Next Page',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton.icon(
                    onLongPress: () {
                      jumpToPageByNumber(currentPage - 10);
                    },
                    onPressed: () {
                      _pageController.previousPage(
                        duration: kPageAnimationDuration,
                        curve: kPageAnimationCurve,
                      );
                    },
                    iconAlignment: IconAlignment.end,
                    label: const Text(
                      'Prev. Page',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
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
