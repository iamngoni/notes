import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/pages/notes.dart';
import 'package:notes/utils/colors.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _toHome() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Notes(),
        ),
      );

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
