import 'package:flutter/material.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/preferences.dart';

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  TextEditingController controller = new TextEditingController();
  JsonPreferences _prefs = new JsonPreferences();
  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: nPurpleAlpha,
        height: dimensions.height,
        width: dimensions.width,
        padding: EdgeInsets.all(
          20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hi 👋. What's your name?",
              style: TextStyle(
                color: nDeepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "e.g. John",
                border: InputBorder.none,
              ),
              onSubmitted: (String text) async {
                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Name can't be empty"),
                    ),
                  );
                  return;
                }
                await _prefs.init();
                _prefs.writeToFile("name", text);
                _prefs.writeToFile("first_attempt", false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeTabBar(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
