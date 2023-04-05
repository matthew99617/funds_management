class Notes{
  final String titles;
  final String notes;
  final DateTime endDate;
  final DateTime startDate;

  Notes({
    required this.titles,
    required this.notes,
    required this.startDate,
    required this.endDate,
  });

  factory Notes.fromJson(Map<String, dynamic> json){
    return Notes(
      titles: json[''],
      notes: json[''],
      startDate: json[''],
      endDate: json[''],
    );
  }
}