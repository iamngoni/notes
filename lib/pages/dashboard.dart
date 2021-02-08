import 'package:flutter/material.dart';
import 'package:notes/controllers/notes.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/functions.dart';
import 'package:notes/widgets/dark_mode_switch.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<NotesState>(builder: (context, controller, child) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 25.0,
                ),
                height: dimensions.height,
                width: dimensions.width,
                decoration: BoxDecoration(
                  color: controller.darkMode == true ? dDark : nPurpleAlpha,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        darkModeSwitch(),
                        RichText(
                          text: TextSpan(
                            text: today().split(" ")[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: controller.darkMode ? dYellow : nPurple,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " ${today().split(" ")[1]} ${today().split(" ")[2]}",
                                style: TextStyle(
                                  color: controller.darkMode
                                      ? dYellow.withOpacity(0.5)
                                      : nDeepPurple,
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
                      "Hi ${controller.username}",
                      style: TextStyle(
                        color: controller.darkMode ? Colors.white : nDeepPurple,
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
                            color: controller.darkMode
                                ? Colors.white
                                : nDeepPurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: dimensions.width,
                  height: dimensions.height * 0.7,
                  decoration: BoxDecoration(
                    color: controller.darkMode ? dBlack : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "TODAY CLASSES",
                              style: TextStyle(
                                color: controller.darkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(text: "(3)"),
                              ],
                            ),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              color: controller.darkMode ? dYellow : nPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 150,
                        decoration: BoxDecoration(
                          color: controller.darkMode ? dCardDark : nCaramel,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
