import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notes{
  final String? id;
  final String title;
  final String notes;
  final DateTime endDate;
  final DateTime startDate;

  Notes({
    this.id,
    required this.title,
    required this.notes,
    required this.startDate,
    required this.endDate,
  });

  factory Notes.fromMap(Map<String, dynamic> json){
    return Notes(
      id: json['id'],
      title: json['title'],
      notes: json['notes'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  static Map<String, dynamic> toJson(Notes note) => {
    'id': note.id,
    'title': note.title,
    'notes': note.notes,
    'startDate': note.startDate.toIso8601String(),
    'endDate': note.endDate.toIso8601String(),
  };

  static String encode(List<Notes> notes) => json.encode(
    notes
        .map<Map<String, dynamic>>((note) => Notes.toJson(note))
        .toList(),
  );

  static List<Notes> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Notes>((item) => Notes.fromMap(item))
          .toList();

  sortByDate (List<Notes> notes) {
    notes.sort((a, b) =>
        a.startDate.day.compareTo(b.startDate.day));
  }
}