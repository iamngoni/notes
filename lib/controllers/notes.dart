import 'package:flutter/material.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/utils/preferences.dart';

class NotesState extends ChangeNotifier {
  List<Note> _notes = [];
  final NotesDatabase _db = new NotesDatabase();
  Map<String, dynamic> _preferences = {};
  JsonPreferences _prefs = new JsonPreferences();

  init() async {
    List<Map<String, dynamic>> results = await _db.getNotes();
    this._notes = [];
    results.forEach((Map<String, dynamic> result) {
      this._notes.add(Note.fromMap(result));
    });
    await _prefs.init();
    this._preferences = _prefs.readFromFile();
    notifyListeners();
  }

  saveNote(Note note) async {
    int result = await NotesDatabase().insertNote(note);
    await this.init();
    if (result != null) {
      return "Saved";
    } else {
      return "Tricky";
    }
  }

  removeNote(Note note) async {
    _db.deleteNote(note);
    await this.init();
    notifyListeners();
  }

  triggerImportance(Note note) async {
    _db.setImportance(note);
    await this.init();
    notifyListeners();
  }

  triggerUnimportance(Note note) async {
    _db.unSetImportance(note);
    await this.init();
    notifyListeners();
  }

  changeDarkMode() async {
    // _preferences['dark_mode'] = !_preferences['dark_mode'];
    _prefs.writeToFile("dark_mode", !_preferences['dark_mode']);
    await this.init();
  }

  List<Note> get notes => _notes;
  int get notesCount => _notes.length;
  List<Note> get important =>
      _notes.where((note) => note.is_important == 1).toList();
  int get importantNotesCount => this.important.length;
  String get username => _preferences['name'];
  bool get darkMode => _preferences['dark_mode'];
}
