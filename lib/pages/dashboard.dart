import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/assignments.dart';
import 'package:notes/controllers/settings.dart';
import 'package:notes/models/assignment.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/functions.dart';
import 'package:notes/widgets/dark_mode_switch.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _dueDate(String date) {
    DateTime now = DateTime.now();
    var later = DateTime.parse(date);
    return now.difference(later).inDays;
  }

  _saveAssignment() {
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _bodyController = new TextEditingController();
    final _key = GlobalKey<FormState>();
    DateTime _selectedDate = DateTime.now();
    return showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("New Assignment 📋"),
        content: Material(
          color: Colors.transparent,
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: nCaramel,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Assignment",
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                        color: nPurple,
                      ),
                    ),
                    controller: _titleController,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Title can't be empty!";
                      }
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: nCaramel,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Deadline",
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                        color: nPurple,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now().subtract(
                              Duration(days: 30),
                            ),
                            lastDate: DateTime.now().add(
                              Duration(days: 30),
                            ),
                          ).then(
                            (selectedDate) {
                              if (selectedDate != null) {
                                _selectedDate = selectedDate;
                                _bodyController.text = _selectedDate.toString();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    controller: _bodyController,
                    keyboardType: TextInputType.datetime,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Body can't be empty!";
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          MaterialButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: Text("Save"),
            onPressed: () async {
              if (_key.currentState.validate()) {
                var result =
                    await Provider.of<AssignmentState>(context, listen: false)
                        .saveAssignment(
                  new Assignment(
                    assignment: _titleController.text,
                    deadline: _bodyController.text,
                  ),
                );

                Navigator.of(context).pop();

                if (result == "Saved") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Saved."),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Not saved."),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<SettingsState>(builder: (context, controller, child) {
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
                            color:
                                controller.darkMode ? nGreyDOut : nDeepPurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
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
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
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
                      ),
                      SizedBox(height: 20.0),
                      classContainer(),
                      classContainer(),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<AssignmentState>(
                              builder: (context, assignmentsController, child) {
                                return RichText(
                                  text: TextSpan(
                                    text: "Assignments ",
                                    style: TextStyle(
                                      color: controller.darkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "(${assignmentsController.assignmentsCount})",
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                color: controller.darkMode ? dYellow : nPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<AssignmentState>(
                        builder: (context, assignmentController, child) {
                          if (assignmentController.assignmentsCount < 1) {
                            return Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: dimensions.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 20.0,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.darkMode ? dCardDark : nCaramel,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No assignments due 🧘",
                                    style: TextStyle(
                                      color: controller.darkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _saveAssignment(),
                                    child: CircleAvatar(
                                      backgroundColor: controller.darkMode
                                          ? dYellow
                                          : nPurple,
                                      child: Icon(
                                        Icons.add,
                                        color: controller.darkMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Stack(
                            children: [
                              Container(
                                height: dimensions.height * 0.244072524,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 20.0,
                                ),
                                child: ListView(
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  children:
                                      assignmentController.assignments.map(
                                    (Assignment assignment) {
                                      return GestureDetector(
                                        onDoubleTap: () => assignmentController
                                            .removeAssignment(assignment),
                                        child: Container(
                                          height: 200,
                                          width: dimensions.width * 0.4,
                                          padding: EdgeInsets.all(10.0),
                                          margin: EdgeInsets.only(right: 10.0),
                                          decoration: BoxDecoration(
                                            color: dCardDark,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deadline",
                                                style: TextStyle(
                                                  color: nGreyDOut,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.wb_sunny_rounded,
                                                    color: nGreyDOut,
                                                    size: 15,
                                                  ),
                                                  _dueDate(assignment.deadline)
                                                          .isNegative
                                                      ? Text(
                                                          " ${_dueDate(assignment.deadline).abs()} days left",
                                                          style: TextStyle(
                                                            color: nGreyDOut,
                                                            fontSize: 13,
                                                          ),
                                                        )
                                                      : Text(
                                                          " ${_dueDate(assignment.deadline).abs()} days overdue",
                                                          style: TextStyle(
                                                            color: nGreyDOut,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                assignment.assignment,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                bottom: 70,
                                child: GestureDetector(
                                  onTap: () => _saveAssignment(),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        controller.darkMode ? dYellow : nPurple,
                                    child: Icon(
                                      Icons.add,
                                      color: controller.darkMode
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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

  Widget classContainer() {
    return Consumer<SettingsState>(
      builder: (context, controller, child) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          height: 100,
          decoration: BoxDecoration(
            color: controller.darkMode ? dCardDark : nCaramel,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "08:00",
                      style: TextStyle(
                        color:
                            controller.darkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "AM",
                      style: TextStyle(
                        color: nGreyDOut,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: controller.darkMode ? Colors.white : Colors.black,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Computer Graphics And Visualisation",
                      style: TextStyle(
                        color:
                            controller.darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: nGreyDOut,
                        ),
                        Text(
                          " Room 101, S-Block",
                          style: TextStyle(
                            color: nGreyDOut.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
