import 'dart:io';

import 'package:notes/models/assignment.dart';
import 'package:sqflite/sqflite.dart';

class AssignmentDatabase {
  static AssignmentDatabase _assignmentDb;
  static Database _database;

  String assignmentsTable = 'assignments';
  String id = 'id';
  String assignment = 'assignment';
  String deadline = 'deadline';

  AssignmentDatabase._createInstance();

  factory AssignmentDatabase() {
    if (_assignmentDb == null) {
      _assignmentDb = AssignmentDatabase._createInstance();
    }
    return _assignmentDb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = new Directory(await getDatabasesPath());
    String path = directory.path + "assignments.db";

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $assignmentsTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $assignment TEXT, $deadline TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getAssignments() async {
    Database db = await this.database;
    var result = await db.query(assignmentsTable);
    return result;
  }

  Future<int> insertAssignment(Assignment assignment) async {
    Database db = await this.database;
    int result = await db.insert(
      assignmentsTable,
      assignment.toMap(),
    );
    return result;
  }

  Future<int> deleteAssignment(Assignment thisAssignment) async {
    Database db = await this.database;
    int result = await db.delete(
      assignmentsTable,
      where: '$assignment = ?',
      whereArgs: [thisAssignment.assignment],
    );
    return result;
  }
}
