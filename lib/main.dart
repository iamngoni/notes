import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/controllers/assignments.dart';
import 'package:notes/controllers/notes.dart';
import 'package:notes/controllers/settings.dart';
import 'package:notes/pages/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesState(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsState(),
        ),
        ChangeNotifierProvider(
          create: (context) => AssignmentState(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<NotesState>(context, listen: false).init();
    Provider.of<SettingsState>(context, listen: false).init();
    Provider.of<AssignmentState>(context, listen: false).init();
    return MaterialApp(
      title: 'notes.',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Poppins',
      ),
      home: Splash(),
    );
  }
}
