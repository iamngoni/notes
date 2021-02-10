import 'dart:convert';

class Assignment {
  final String deadline;
  final String assignment;
  Assignment({
    this.deadline,
    this.assignment,
  });

  Map<String, dynamic> toMap() {
    return {
      'deadline': deadline,
      'assignment': assignment,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Assignment(
      deadline: map['deadline'],
      assignment: map['assignment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source));
}
