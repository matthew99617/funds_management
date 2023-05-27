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

  factory Notes.fromJson(Map<String, dynamic> json){
    return Notes(
      id: json[''],
      title: json[''],
      notes: json[''],
      startDate: json[''],
      endDate: json[''],
    );
  }

  sortByDate (List<Notes> notes) {
    notes.sort((a, b) =>
        a.startDate.day.compareTo(b.startDate.day));
  }
}