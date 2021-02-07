import 'package:flutter/material.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/functions.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 25.0,
          ),
          height: dimensions.height,
          width: dimensions.width,
          decoration: BoxDecoration(
            color: nPurpleAlpha,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: today().split(" ")[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: nDeepPurple,
                      ),
                      children: [
                        TextSpan(
                          text:
                              " ${today().split(" ")[1]} ${today().split(" ")[2]}",
                          style: TextStyle(
                            color: nDeepPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Hi Ngoni",
                style: TextStyle(
                  color: nDeepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Container(
                width: dimensions.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    "Here is a list of schedule you need to check",
                    style: TextStyle(
                      color: nDeepPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
