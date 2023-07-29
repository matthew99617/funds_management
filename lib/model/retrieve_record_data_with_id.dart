import 'dart:convert';

import 'package:funds_management/model/record.dart';

class RetrieveRecordDataWithID{
  final String id;
  final Record record;

  RetrieveRecordDataWithID({
    required this.id,
    required this.record,
  });

  factory RetrieveRecordDataWithID.fromMap(Map<String, dynamic> json){
    return RetrieveRecordDataWithID(
      id: json['id'],
      record: json['record'],
    );
  }

  static Map<String, dynamic> toJson(RetrieveRecordDataWithID record) => {
    'id': record.id,
    'basicMonth': record.record,
  };

  static String encode(List<RetrieveRecordDataWithID> record) => json.encode(
    record
        .map<Map<String, dynamic>>((record) => RetrieveRecordDataWithID.toJson(record))
        .toList(),
  );

  static List<RetrieveRecordDataWithID> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<RetrieveRecordDataWithID>((item) => RetrieveRecordDataWithID.fromMap(item))
          .toList();
}