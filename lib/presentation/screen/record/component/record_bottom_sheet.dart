import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funds_management/firebase/FireStoreDataBase.dart';
import 'package:funds_management/model/retrieve_record_data_with_id.dart';
import 'package:funds_management/shared/share_preference_helper.dart';
import 'package:intl/intl.dart';

import '../../../../model/record.dart';

class RecordBottomSheet extends StatefulWidget {

  final String? id;
  final String? description;
  final String? remark;
  final double? amount;
  final DateTime? purchaseDate;
  final bool? isPaid;

  RecordBottomSheet({Key? key, this.id, this.description, this.amount ,this.remark, this.purchaseDate, this.isPaid}) : super(key: key);

  @override
  State<RecordBottomSheet> createState() => _RecordBottomSheetState();
}

class _RecordBottomSheetState extends State<RecordBottomSheet> {

  final dateInput = TextEditingController();
  final myControllerRemark = TextEditingController();
  final myControllerDescription = TextEditingController();
  final myControllerAmount = TextEditingController();
  final myControllerPaid = TextEditingController();
  bool? _selectedValue;
  final db = FirebaseFirestore.instance;

  final GlobalKey _formKey = GlobalKey<FormState>();
  var temp = "";

  DateTime firstYear = DateTime.utc(DateTime.now().year.toInt() - 1 , 12, 31);
  DateTime lastYear = DateTime.now();

  @override
  void dispose() {
    myControllerRemark.dispose();
    myControllerDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.isPaid != null){
      _selectedValue = widget.isPaid;
    }

    if (widget.purchaseDate == null){
      dateInput.text = "";
    } else {
      dateInput.text = DateFormat('yyyy-MM-dd').format(widget.purchaseDate!);
    }

    if (widget.amount != null){
      myControllerAmount.text = widget.amount.toString();
    }

    if (widget.description != null){
      myControllerDescription.text = widget.description.toString();
    }

    if (widget.remark != null){
      myControllerRemark.text = widget.remark.toString();
    }
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
                  widget.remark == null
                      ? Text('Add Record', style: TextStyle(fontSize: 25.0),)
                      : Text('Edit Record', style: TextStyle( fontSize: 25.0),),
                  SizedBox(height: 15.0),
                  TextFormField(
                    autofocus: true,
                    controller: myControllerDescription,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey[800],
                      ),
                      labelText: 'Descriptions',
                      hintText: widget.remark != null ? '${widget.remark}' : 'Please Input Descriptions',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (v) {
                      return v!.trim().isNotEmpty ? null : "You don't have any change on Descriptions!!";
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: myControllerAmount, //editing controller of this TextField
                    decoration: InputDecoration(
                      labelText: "Amount", //label text of field
                      hintText: widget.amount != null ? '${widget.amount}' : 'Please Input Amount',
                    ),
                    validator: (v) {
                      return v!.trim().isNotEmpty ? null : "You don't have any change on Amount!!";
                    },
                  ),
                  TextFormField(
                    controller: myControllerRemark,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Remark',
                      hintText: widget.description != null ? '${widget.description}' : 'Please Input Remark',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: dateInput, //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Purchase Date", //label text of field
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
                          dateInput.text = formattedDate; //set output date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                    validator: (v) {
                      return v!.trim().isNotEmpty ? null : "You don't have any change on PurchaseDate!!";
                    },
                  ),
                  SizedBox(height: 10,),
                  DropdownButtonFormField<bool>(
                    dropdownColor: Color(0xE5FFFFFF),
                    value: _selectedValue,
                    hint: Text('Paid?'),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(
                          'Not select',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    validator: (v) {
                      return v != null ? null : "You don't have any change on this field!!";
                    },
                  ),

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
                                if ((_formKey.currentState as FormState).validate() && _selectedValue != null) {
                                  if (widget.id == null){
                                    createData(
                                      myControllerDescription.text,
                                      Decimal.parse(myControllerAmount.text).toDouble(),
                                      myControllerRemark.text,
                                      DateTime.parse(dateInput.text),
                                      _selectedValue!,
                                    );
                                  } else {
                                    updateData(
                                      widget.id.toString(),
                                      myControllerDescription.text,
                                      Decimal.parse(myControllerAmount.text).toDouble(),
                                      myControllerRemark.text,
                                      DateTime.parse(dateInput.text),
                                      _selectedValue!,
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
                                      myControllerDescription.text,
                                      Decimal.parse(myControllerAmount.text).toDouble(),
                                      myControllerRemark.text,
                                      DateTime.parse(dateInput.text),
                                      _selectedValue!,
                                    );
                                  } else {
                                    updateData(
                                      widget.id.toString(),
                                      myControllerDescription.text,
                                      Decimal.parse(myControllerAmount.text).toDouble(),
                                      myControllerRemark.text,
                                      DateTime.parse(dateInput.text),
                                      _selectedValue!,
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
                        SizedBox(height: 20,)
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
              style: TextStyle(color: Colors.black87),
            ),
            content: const Text(
              'Are you sure to remove the records?',
              style: TextStyle(color: Colors.black87),
            ),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    // Remove the box
                    await FirebaseFirestore.instance.collection('records').doc(widget.id).delete().then(
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
      String description,
      double amount,
      String remark,
      DateTime purchaseDate,
      bool isPaid,
      ) async {
    Map<String, dynamic> data ={
      'description': description,
      'amount': amount,
      'remark': remark,
      'purchaseDate': purchaseDate,
      'isPaid': isPaid,
    };

    await FirebaseFirestore.instance.collection('records').add(data).then(
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
      String description,
      double amount,
      String remark,
      DateTime purchaseDate,
      bool isPaid,
      ) async {
    Map<String, dynamic> data ={
      'id': id,
      'description': description,
      'amount': amount,
      'remark': remark,
      'purchaseDate': purchaseDate,
      'isPaid': isPaid,
    };

    await FirebaseFirestore.instance.collection('records').doc(id).update(data).then(
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

    var snapshot = await FireStoreDataBase().getRecordData();
    List<Record> savedList = [];

    savedList.clear();
    var dataList = (snapshot as List)
        .map((item) => item as RetrieveRecordDataWithID).toList();
    for (var result in dataList) {
      var list = Record(
        id: result.id,
        purchaseDate: result.record.purchaseDate,
        description: result.record.description,
        amount: result.record.amount,
        remark: result.record.remark,
        isPaid: result.record.isPaid,
      );

      /**
       *  Remember You have Filtering the Data, Just CURRENT MONTH only
       */

      savedList.add(list);
    }
    final String encodeData = Record.encode(savedList);
    await SharePreferenceHelper.saveRecordData(encodeData);

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
