import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/controllers/notes.dart';
import 'package:notes/pages/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotesState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<NotesState>(context, listen: false).init();
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
