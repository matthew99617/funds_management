import 'dart:convert';

import 'notes.dart';

class RetrieveDataWithID{
  final String id;
  final Notes notes;

  RetrieveDataWithID({
    required this.id,
    required this.notes,
  });

  factory RetrieveDataWithID.fromMap(Map<String, dynamic> json){
    return RetrieveDataWithID(
      id: json['id'],
      notes: json['notes'],
    );
  }

  static Map<String, dynamic> toJson(RetrieveDataWithID note) => {
    'id': note.id,
    'notes': note.notes,
  };

  static String encode(List<RetrieveDataWithID> notes) => json.encode(
    notes
        .map<Map<String, dynamic>>((note) => RetrieveDataWithID.toJson(note))
        .toList(),
  );

  static List<RetrieveDataWithID> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<RetrieveDataWithID>((item) => RetrieveDataWithID.fromMap(item))
          .toList();
}