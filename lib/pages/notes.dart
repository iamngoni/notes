import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/controllers/notes.dart';
import 'package:notes/controllers/settings.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/functions.dart';
import 'package:notes/widgets/dark_mode_switch.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<String> _categories = ["Notes", "Important"];
  int _catIndex = 0;

  _saveNote() {
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _bodyController = new TextEditingController();
    final _key = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("New Note 📋"),
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
                      labelText: "Title",
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
                      labelText: "Body",
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                        color: nPurple,
                      ),
                    ),
                    controller: _bodyController,
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
                    await Provider.of<NotesState>(context, listen: false)
                        .saveNote(
                  new Note(
                    title: _titleController.text,
                    body: _bodyController.text,
                    date: DateTime.now(),
                    updated_at: DateTime.now(),
                    is_important: 0,
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
    return Consumer<SettingsState>(
      builder: (context, controller, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _saveNote,
            child: Icon(
              Icons.add,
              size: 30,
              color: controller.darkMode ? Colors.black : Colors.white,
            ),
            backgroundColor: controller.darkMode ? dYellow : nPurple,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: dimensions.height,
              width: dimensions.width,
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              color: controller.darkMode ? dBlack : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notes.",
                        style: TextStyle(
                          color: controller.darkMode ? dYellow : nPurple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      darkModeSwitch(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      notesCount(),
                      importantNotesCount(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _categories.map((category) {
                      bool isSelect =
                          _catIndex == _categories.indexOf(category);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _catIndex = _categories.indexOf(category);
                          });
                        },
                        child: Column(
                          crossAxisAlignment: category == "Notes"
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: isSelect
                                    ? controller.darkMode
                                        ? dYellow
                                        : nPurple
                                    : nGreyDOut,
                              ),
                            ),
                            isSelect
                                ? category == "Notes"
                                    ? Row(
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 30,
                                            color: controller.darkMode
                                                ? Colors.white
                                                : nPurple,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 3,
                                            width: 5,
                                            decoration: BoxDecoration(
                                              color: controller.darkMode
                                                  ? Colors.white
                                                  : nPurple,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 5,
                                            decoration: BoxDecoration(
                                              color: controller.darkMode
                                                  ? Colors.white
                                                  : nPurple,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 3,
                                            width: 50,
                                            color: controller.darkMode
                                                ? Colors.white
                                                : nPurple,
                                          ),
                                        ],
                                      )
                                : SizedBox.shrink(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Consumer<NotesState>(
                    builder: (context, notesController, child) {
                      return notesController.notesCount > 0
                          ? ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: _catIndex == 0
                                  ? notesController.notes.map((note) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: noteContainer(note: note),
                                      );
                                    }).toList()
                                  : notesController.important.map((note) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child:
                                            importantNoteContainer(note: note),
                                      );
                                    }).toList(),
                            )
                          : Container(
                              width: dimensions.width,
                              decoration: BoxDecoration(
                                color:
                                    controller.darkMode ? dCardDark : nCaramel,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "0 notes. 😣",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.darkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget noteContainer({@required Note note}) {
    return Consumer<SettingsState>(builder: (context, controller, child) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: nCaramel,
              child: Icon(
                note.is_important == 1 ? Icons.star : Icons.star_outline,
                color: controller.darkMode ? dYellow : nPurple,
              ),
            ),
            onTap: () => note.is_important == 1
                ? Provider.of<NotesState>(context, listen: false)
                    .triggerUnimportance(note)
                : Provider.of<NotesState>(context, listen: false)
                    .triggerImportance(note),
          ),
        ],
        secondaryActions: <Widget>[
          GestureDetector(
            onTap: () => Provider.of<NotesState>(context, listen: false)
                .removeNote(note),
            child: CircleAvatar(
              backgroundColor: controller.darkMode ? dYellow : nPurple,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: controller.darkMode ? dCardDark : nCaramel,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: controller.darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    readableTime(
                      note.updated_at,
                    ),
                    style: TextStyle(
                      color: nGreyDOut,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  note.body,
                  style: TextStyle(
                    color: controller.darkMode ? nGreyDOut : Colors.black,
                  ),
                ),
              ),
              Text(
                readableDate(note.date),
                style: TextStyle(
                  color: nGreyDOut,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget importantNoteContainer({@required Note note}) {
    return Consumer<SettingsState>(builder: (context, controller, child) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          GestureDetector(
            onTap: () => Provider.of<NotesState>(context, listen: false)
                .triggerUnimportance(note),
            child: CircleAvatar(
              backgroundColor: controller.darkMode ? dYellow : nPurple,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: controller.darkMode ? dCardDark : nCaramel,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: controller.darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    readableTime(
                      note.updated_at,
                    ),
                    style: TextStyle(
                      color: nGreyDOut,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  note.body,
                  style: TextStyle(
                    color: controller.darkMode ? nGreyDOut : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
              Text(
                readableDate(note.date),
                style: TextStyle(
                  color: nGreyDOut,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget notesCount() {
    return Consumer<SettingsState>(
      builder: (context, controller, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.45,
          padding: EdgeInsets.all(20.0),
          height: 200,
          decoration: BoxDecoration(
            color: controller.darkMode ? dYellow : nPurple,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: TextStyle(
                  color: controller.darkMode ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Consumer<NotesState>(
                builder: (context, notesController, child) {
                  return Text(
                    notesController.notesCount.toString(),
                    style: TextStyle(
                      color: controller.darkMode ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget importantNotesCount() {
    return Consumer<SettingsState>(
      builder: (context, controller, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.45,
          padding: EdgeInsets.all(20.0),
          height: 200,
          decoration: BoxDecoration(
            color: controller.darkMode ? dCardDark : nCaramel,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Important",
                style: TextStyle(
                  color: nGreyDOut,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Consumer<NotesState>(
                builder: (context, notesController, child) {
                  return Text(
                    notesController.importantNotesCount.toString(),
                    style: TextStyle(
                      color: controller.darkMode ? nGreyDOut : dCardDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
