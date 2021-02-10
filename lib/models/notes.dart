import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Note {
  final String title;
  final String body;
  final DateTime date;
  // ignore: non_constant_identifier_names
  final DateTime updated_at;
  // ignore: non_constant_identifier_names
  final int is_important;
  Note({
    @required this.title,
    @required this.body,
    @required this.date,
    // ignore: non_constant_identifier_names
    @required this.updated_at,
    // ignore: non_constant_identifier_names
    @required this.is_important,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'date': date.toString(),
      'updated_at': updated_at.toString(),
      'is_important': is_important
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Note(
      title: map['title'],
      body: map['body'],
      date: DateTime.parse(map['date']),
      updated_at: DateTime.parse(map['updated_at']),
      is_important: map['is_important'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}
