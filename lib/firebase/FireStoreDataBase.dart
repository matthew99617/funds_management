import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:funds_management/model/notes.dart';
import 'package:funds_management/model/retrieve_data_with_id_notes.dart';

class FireStoreDataBase {
  List toDoList = [];
  final CollectionReference collectionRef =
  FirebaseFirestore.instance.collection("plans");

  Future getData() async{
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          Timestamp tStartDate = result.get('startDate');
          Timestamp tEndDate = result.get('endDate');

          var data = RetrieveDataWithID(
            id: result.id.toString(),
            notes: Notes(
                title: result.get('title'),
                notes: result.get('notes'),
                startDate: DateTime.parse(tStartDate.toDate().toString()),
                endDate: DateTime.parse(tEndDate.toDate().toString()),
            )
          );

          toDoList.add(data);
        }
      });

      return toDoList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}