import 'dart:convert';

class Notes{
  final int id;
  final String title;
  final String notes;
  final DateTime endDate;
  final DateTime startDate;

  Notes({
    required this.id,
    required this.title,
    required this.notes,
    required this.startDate,
    required this.endDate,
  });

  String toEncodeString() => json.encode(toMap());

  factory Notes.decode(String str) => Notes.fromMap(json.decode(str));

  factory Notes.fromMap(Map<String, dynamic> json){
    return Notes(
      id: json['id'],
      title: json['title'],
      notes: json['notes'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "notes": notes,
    "startDate": startDate,
    "endDate": endDate,
  };

  sortByDate (List<Notes> notes) {
    notes.sort((a, b) =>
        a.startDate.day.compareTo(b.startDate.day));
  }
}