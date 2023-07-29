import 'dart:convert';

class Record{
  String? id;
  final DateTime purchaseDate;
  final String description;
  final double amount;
  late final bool isPaid;
  final String remark;
  final String imageUrl;

  Record({
    this.id,
    required this.purchaseDate,
    required this.description,
    required this.amount,
    required this.remark,
    required this.isPaid,
    this.imageUrl = '',
  });

  factory Record.fromMap(Map<String, dynamic> json){
    return Record(
      id: json['id'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
      description: json['description'],
      amount: json['amount'],
      remark: json['remark'],
      isPaid: json['isPaid'],
    );
  }


  static Map<String, dynamic> toJson(Record record) => {
    'id': record.id,
    'purchaseDate': record.purchaseDate.toIso8601String(),
    'description': record.description,
    'amount': record.amount,
    'isPaid': record.isPaid,
    'remark': record.remark,
    'imageUrl': record.imageUrl,
  };

  static String encode(List<Record> record) => json.encode(
    record
        .map<Map<String, dynamic>>((record) => Record.toJson(record))
        .toList(),
  );

  static List<Record> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<Record>((item) => Record.fromMap(item))
          .toList();

}