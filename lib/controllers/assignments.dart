import 'package:flutter/material.dart';
import 'package:notes/database/assignment.dart';
import 'package:notes/models/assignment.dart';

class AssignmentState extends ChangeNotifier {
  List<Assignment> _assignments = [];
  final AssignmentDatabase _db = new AssignmentDatabase();

  init() async {
    List<Map<String, dynamic>> results = await _db.getAssignments();
    this._assignments = [];
    results.forEach((Map<String, dynamic> result) {
      this._assignments.add(Assignment.fromMap(result));
    });
    notifyListeners();
  }

  saveAssignment(Assignment assignment) async {
    int result = await AssignmentDatabase().insertAssignment(assignment);
    await this.init();
    if (result != null) {
      return "Saved";
    } else {
      return "Tricky";
    }
  }

  removeAssignment(Assignment assignment) async {
    _db.deleteAssignment(assignment);
    await this.init();
    notifyListeners();
  }

  List<Assignment> get assignments => _assignments;
  int get assignmentsCount => _assignments.length;
}
