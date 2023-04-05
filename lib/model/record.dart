class Record{
  final DateTime dateTime;
  final String purchaseItem;
  final String description;
  final String type;
  final bool isChecked;

  Record({
    required this.purchaseItem,
    required this.dateTime,
    required this.description,
    required this.type,
    required this.isChecked,
  });

  factory Record.fromJson(Map<String, dynamic> json){
    return Record(
      purchaseItem: json[''],
      dateTime: json[''],
      description: json[''],
      type: json[''],
      isChecked: json[false]
    );
  }
}