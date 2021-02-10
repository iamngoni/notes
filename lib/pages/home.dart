import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/settings.dart';
import 'package:notes/pages/dashboard.dart';
import 'package:notes/pages/notes.dart';
import 'package:notes/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeTabBar extends StatefulWidget {
  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  int _index = 0;
  List _pages = [
    Dashboard(),
    Notes(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<SettingsState>(builder: (context, controller, child) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: controller.darkMode ? dYellow : nPurple,
          unselectedItemColor: controller.darkMode ? Colors.white : Colors.grey,
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: controller.darkMode ? dCardDark : Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(_index == 0 ? Icons.home : Icons.home_outlined),
              label: "Home",
              backgroundColor: controller.darkMode ? dCardDark : Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _index == 1
                    ? Icons.insert_drive_file
                    : Icons.insert_drive_file_outlined,
              ),
              label: "Notes",
              backgroundColor: controller.darkMode ? dCardDark : Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        );
      }),
      body: _pages[_index],
    );
  }
}
