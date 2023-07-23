import 'package:cloud_firestore/cloud_firestore.dart';

class Record{
  final DateTime purchaseDate;
  final String description;
  final double amount;
  late final bool checkedBox;
  final String imageUrl;

  Record({
    required this.purchaseDate,
    required this.description,
    required this.amount,
    required this.checkedBox,
    this.imageUrl = '',
  });

  Record.fromMap(Map<String, dynamic> data)
      : purchaseDate = (data['purchaseDate'] as Timestamp).toDate(),
        description = data['description'],
        amount = data['amount'].toDouble(),
        checkedBox = data['checkedBox'],
        imageUrl = data['imageUrl'];

  Map<String, dynamic> toMap() => {
    'purchaseDate': Timestamp.fromDate(purchaseDate),
    'description': description,
    'amount': amount,
    'checkedBox': checkedBox,
    'imageUrl': imageUrl,
  };
}