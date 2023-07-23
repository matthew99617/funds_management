import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funds_management/firebase/FireStoreDataBase.dart';
import 'package:funds_management/shared/share_preference_helper.dart';
import 'package:intl/intl.dart';

import '../../../../model/notes.dart';
import '../../../../model/retrieve_data_with_id_notes.dart';

class CalendarBottomSheet extends StatefulWidget {

  final ScrollController scrollController = ScrollController();

  final String? id;
  final String? title;
  final String? notes;
  final DateTime? startDate;
  final DateTime? endDate;

  CalendarBottomSheet({Key? key, this.id, this.title, this.notes, this.startDate, this.endDate}) : super(key: key);

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {

  final dateInputStartDate = TextEditingController();
  final dateInputEndDate = TextEditingController();
  final myControllerTitle = TextEditingController();
  final myControllerDescription = TextEditingController();
  final db = FirebaseFirestore.instance;

  final GlobalKey _formKey = GlobalKey<FormState>();
  var temp = "";

  DateTime firstYear = DateTime.now();
  DateTime lastYear = DateTime.utc(DateTime.now().year.toInt() + 1 , 12, 31);

  @override
  void dispose() {
    myControllerTitle.dispose();
    myControllerDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.startDate == null){
      dateInputStartDate.text = "";
    } else {
      dateInputStartDate.text = DateFormat('yyyy-MM-dd').format(widget.startDate!);
    }

    if (widget.endDate == null){
      dateInputEndDate.text = "";
    } else {
      dateInputEndDate.text = DateFormat('yyyy-MM-dd').format(widget.endDate!);
    }

    myControllerTitle.addListener((){
      _printTitle();
    });
    myControllerDescription.addListener((){
      _printDescription();
    });
  }

  void _printTitle(){
    print("${myControllerTitle.text}");
  }

  void _printDescription(){
    print("${myControllerDescription.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,

              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    widget.notes == null
                        ? Text('Add Event', style: TextStyle(fontSize: 25.0),)
                        : Text('Edit Event', style: TextStyle( fontSize: 25.0),),
                    SizedBox(height: 15.0),
                    TextFormField(
                      autofocus: true,
                      controller: myControllerTitle,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: widget.title != null ? '${widget.title}' : 'Please Input Descriptions',
                      ),
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "You don't have any change on Title!!";
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: myControllerDescription,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        labelText: 'Descriptions',
                        hintText: widget.notes != null ? '${widget.notes}' : 'Please Input Descriptions',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "You don't have any change on Descriptions!!";
                      },
                    ),
                    TextFormField(
                      controller: dateInputStartDate, //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Start Date", //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: firstYear,
                          lastDate: lastYear,
                        );

                        if(pickedDate != null){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateInputStartDate.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "You don't have any change on StartDate!!";
                      },
                    ),
                    TextFormField(
                      controller: dateInputEndDate, //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today,), //icon of text field
                        labelText: "End Date", //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        if (dateInputStartDate != null){
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: lastYear,
                          );

                          if(pickedDate != null){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16

                            setState(() {
                              dateInputEndDate.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        } else {
                          setState(() {
                            dateInputEndDate.text = "You Should pick up the Start Date first";
                          });
                        }
                      },
                      validator: (v) {
                        if (!v!.trim().isNotEmpty){
                          return "You don't have any change on EndDate!!";
                        } else if (DateTime.parse(dateInputEndDate.text).isBefore(DateTime.parse(dateInputStartDate.text))){
                          return "You cannot input before StartDate";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Text(temp.toString()),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          if(widget.id == null) ...[
                            Expanded(
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Submit"),
                                ),
                                onPressed: () async{
                                  if ((_formKey.currentState as FormState).validate()) {
                                    if (widget.id == null){
                                      createData(
                                          myControllerTitle.text,
                                          myControllerDescription.text,
                                          DateTime.parse(dateInputStartDate.text),
                                          DateTime.parse(dateInputEndDate.text)
                                      );
                                    } else {
                                      updateData(
                                          widget.id!,
                                          myControllerTitle.text,
                                          myControllerDescription.text,
                                          DateTime.parse(dateInputStartDate.text),
                                          DateTime.parse(dateInputEndDate.text)
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Submit"),
                                ),
                                onPressed: () async{
                                  if ((_formKey.currentState as FormState).validate()) {
                                    if (widget.id == null){
                                      createData(
                                          myControllerTitle.text,
                                          myControllerDescription.text,
                                          DateTime.parse(dateInputStartDate.text),
                                          DateTime.parse(dateInputEndDate.text)
                                      );
                                    } else {
                                      updateData(
                                          widget.id!,
                                          myControllerTitle.text,
                                          myControllerDescription.text,
                                          DateTime.parse(dateInputStartDate.text),
                                          DateTime.parse(dateInputEndDate.text)
                                      );
                                    }


                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Delete"),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, // Background color
                                ),
                                onPressed: () {
                                  _delete(context);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        )
      ],
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Please Confirm',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text(
              'Are you sure to remove the plans?',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    // Remove the box
                    await FirebaseFirestore.instance.collection('plans').doc(widget.id).delete().then(
                            (value) => {
                              fetchDataAgain(),
                              Navigator.pop(context, true),
                              showFlutterToast("Please Wait a moment"),
                              Future.delayed(Duration(seconds: 1)).whenComplete(() => {
                                showFlutterToast("Delete Successfully"),
                                Navigator.pop(context, true),
                              })
                            });
                    },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  createData (
      String title,
      String notes,
      DateTime startDate,
      DateTime endDate,
  ) async {
    Map<String, dynamic> data ={
      'title': title,
      'notes': notes,
      'startDate': startDate,
      'endDate': endDate,
    };

    await FirebaseFirestore.instance.collection('plans').add(data).then(
            (value) => {
              fetchDataAgain(),
              showFlutterToast("Please Wait a moment"),
              Future.delayed(Duration(seconds: 1)).whenComplete(() => {
              showFlutterToast("Insert Successfully"),
                Navigator.pop(context, true),
              })
            });
  }

  updateData (
      String id,
      String title,
      String notes,
      DateTime startDate,
      DateTime endDate,
  ) async {
    Map<String, dynamic> data ={
      'title': title,
      'notes': notes,
      'startDate': startDate,
      'endDate': endDate,
    };

    await FirebaseFirestore.instance.collection('plans').doc(id).update(data).then(
            (value) => {
              fetchDataAgain(),
              showFlutterToast("Please Wait a moment"),
              Future.delayed(Duration(seconds: 1)).whenComplete(() => {
                showFlutterToast("Updated Successfully"),
                Navigator.pop(context, true),
              })
            });
  }

  Future fetchDataAgain() async{

    var snapshot = await FireStoreDataBase().getData();
    List<Notes> savedList = [];

    savedList.clear();
    var dataList = (snapshot as List)
        .map((item) => item as RetrieveDataWithID).toList();
    for (var result in dataList) {
      var toDoList = Notes(
        id: result.id,
        title: result.notes.title,
        notes: result.notes.notes,
        startDate: result.notes.startDate,
        endDate: result.notes.endDate,
      );

      /**
       *  Remember You have Filtering the Data, Just CURRENT MONTH only
       */

      savedList.add(toDoList);
    }
    final String encodeData = Notes.encode(savedList);
    await SharePreferenceHelper.saveListData(encodeData);

    // final String encodeData = Notes.encode(savedList as List<Notes>);
    // return encodeData;
  }

  showFlutterToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
