import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitabulazkar/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../components/input_dialog.dart';
import '../components/url_opener.dart';
import '../screens/azkar_list.dart';

class NavDrawer extends StatefulWidget {
  final ValueChanged onResult;
  const NavDrawer({super.key, required this.onResult});
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  void versionFinder() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    setState(() => _version = version);
  }

  late String _version = kAppVersion;

  void makeItemSelected(int currentItem) {
    for (int i = 0; i < kItemSelectionList.length; i++) {
      if (i == currentItem) {
        kItemSelectionList[i] = true;
      } else {}
      kItemSelectionList[i] = false;
    }
  }

  CustomInputDialogBox customInputDialog = CustomInputDialogBox();
  @override
  void initState() {
    super.initState();
    versionFinder();
  }

  @override
  Widget build(BuildContext context) {
    int selectedPage = -1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              //color: kMainColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/background/banner.png'),
              ),
            ),
            child: null,
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text(
              'Home',
            ),
            selected: kItemSelectionList[0],
            selectedColor: kMainColor,
            selectedTileColor: kSelectedMenuItemColor,
            onTap: () {
              selectedPage = 5;
              widget.onResult(selectedPage);
              makeItemSelected(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.manage_search),
            title: const Text(
              'Search by Zikr',
            ),
            selected: kItemSelectionList[1],
            selectedColor: kMainColor,
            selectedTileColor: kSelectedMenuItemColor,
            onTap: () async {
              try {
                selectedPage = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return AzkarListScreen();
                }));
              } catch (e) {
                // print(e);
              }
              widget.onResult(selectedPage);
              //print('Menu_Bar Page : $selectedPage');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.find_in_page),
            title: const Text('Find by Page Number'),
            selected: kItemSelectionList[2],
            selectedColor: kMainColor,
            selectedTileColor: kSelectedMenuItemColor,
            onTap: () async {
              Navigator.pop(context);
              await customInputDialog.displayTextInputDialog(context);
              widget.onResult(customInputDialog.getInputDialogData());
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            selected: kItemSelectionList[3],
            selectedColor: kMainColor,
            selectedTileColor: kSelectedMenuItemColor,
            onTap: () {
              Navigator.pop(context);

              showAboutDialog(
                context: context,
                applicationName: kApplicationName,
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
          ),
        ],
      ),
    );
  }
}
