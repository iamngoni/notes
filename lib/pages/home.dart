import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/dashboard.dart';
import 'package:notes/pages/notes.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_index == 0 ? Icons.home : Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _index == 1
                  ? Icons.insert_drive_file
                  : Icons.insert_drive_file_outlined,
            ),
            label: "Notes",
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _pages[_index],
    );
  }
}
