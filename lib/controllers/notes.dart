import 'package:flutter/material.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/models/notes.dart';

class NotesState extends ChangeNotifier {
  List<Note> _notes = [];
  final NotesDatabase _db = new NotesDatabase();

  init() async {
    List<Map<String, dynamic>> results = await _db.getNotes();
    this._notes = [];
    results.forEach((Map<String, dynamic> result) {
      this._notes.add(Note.fromMap(result));
    });
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

  List<Note> get notes => _notes;
  int get notesCount => _notes.length;
  List<Note> get important =>
      _notes.where((note) => note.is_important == 1).toList();
  int get importantNotesCount => this.important.length;
}
