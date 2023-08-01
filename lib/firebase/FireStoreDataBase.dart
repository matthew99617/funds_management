import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:funds_management/model/notes.dart';
import 'package:funds_management/model/retrieve_data_with_id_notes.dart';
import 'package:funds_management/model/retrieve_record_data_with_id.dart';

import '../model/record.dart';
import '../shared/share_preference_helper.dart';

class FireStoreDataBase {
  List toDoList = [];
  List recordList = [];
  final CollectionReference collectionPermissionRef =
  FirebaseFirestore.instance.collection("permission");

  final CollectionReference collectionPlansRef =
  FirebaseFirestore.instance.collection("plans");

  final CollectionReference collectionRecordReference =
  FirebaseFirestore.instance.collection("records");

  Future getPlanData() async{
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionPlansRef.get().then((querySnapshot) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {

          Timestamp tStartDate = querySnapshot.docs[i].get('startDate');
          Timestamp tEndDate = querySnapshot.docs[i].get('endDate');

          var data = RetrieveDataWithID(
            id: querySnapshot.docs[i].id.toString(),
            notes: Notes(
              title: querySnapshot.docs[i].get('title'),
              notes: querySnapshot.docs[i].get('notes'),
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

  Future getRecordData() async{
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRecordReference.get().then((querySnapshot) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {

          Timestamp tPurchaseDate = querySnapshot.docs[i].get('purchaseDate');

          var data = RetrieveRecordDataWithID(
              id: querySnapshot.docs[i].id.toString(),
              record: Record(
                description: querySnapshot.docs[i].get('description'),
                purchaseDate: DateTime.parse(tPurchaseDate.toDate().toString()),
                amount: querySnapshot.docs[i].get('amount'),
                remark: querySnapshot.docs[i].get('remark'),
                isPaid: querySnapshot.docs[i].get('isPaid'),
              ),
          );

          recordList.add(data);
        }
      });

      return recordList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      SharePreferenceHelper.saveIsLogin(true);
      SharePreferenceHelper.saveEmail(email);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  getPermission(String email) async{
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionPermissionRef.get().then((querySnapshot) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          if (querySnapshot.docs[i].get('email').toString() == email){
            SharePreferenceHelper.saveRecordPermission(querySnapshot.docs[i].get('record'));
            SharePreferenceHelper.saveCalendarPermission(querySnapshot.docs[i].get('calendar'));
          }
        }
      });

    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}