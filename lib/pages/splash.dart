import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/pages/first_time.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _toHome() async {
    JsonPreferences _prefs = new JsonPreferences();
    await _prefs.init();
    Map<String, dynamic> preferences = _prefs.readFromFile();
    if (preferences["first_attempt"] == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FirstTime(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeTabBar(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), _toHome);
  }

  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: dimensions.height,
        width: dimensions.width,
        color: Colors.white,
        child: Center(
          child: Text(
            "notes.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: nPurple,
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
