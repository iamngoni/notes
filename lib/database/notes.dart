import 'dart:io';

import 'package:notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static NotesDatabase _notesDb;
  static Database _database;

  String notesTable = 'notes';
  String id = 'id';
  String title = 'title';
  String body = 'body';
  String date = 'date';
  String updatedAt = 'updated_at';
  String isImportant = 'is_important';

  NotesDatabase._createInstance();

  factory NotesDatabase() {
    if (_notesDb == null) {
      _notesDb = NotesDatabase._createInstance();
    }
    return _notesDb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = new Directory(await getDatabasesPath());
    String path = directory.path + "notes.db";

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $notesTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $body TEXT, $date TEXT, $updatedAt TEXT, $isImportant INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    Database db = await this.database;
    var result = await db.query(notesTable);
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    int result = await db.insert(
      notesTable,
      note.toMap(),
    );
    return result;
  }

  Future<int> setImportance(Note note) async {
    Database db = await this.database;
    int result = await db.update(
      notesTable,
      {"is_important": 1},
      where: '$title = ?',
      whereArgs: [note.title],
    );
    return result;
  }

  Future<int> unSetImportance(Note note) async {
    Database db = await this.database;
    int result = await db.update(
      notesTable,
      {"is_important": 0},
      where: '$title = ?',
      whereArgs: [note.title],
    );
    return result;
  }

  Future<int> deleteNote(Note note) async {
    Database db = await this.database;
    int result = await db.delete(
      notesTable,
      where: '$title = ?',
      whereArgs: [note.title],
    );
    return result;
  }
}
