import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/presentation/screen/record/component/MonthListItem.dart';

import '../../../model/record.dart';
import '../../../shared/icons_data.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _checkedBoxController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  CollectionReference recordReference =
  FirebaseFirestore.instance.collection('records');

  List<Record> _recordList = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  void _fetchExpenses() async {
    QuerySnapshot snapshot = await recordReference.get();
    setState(() {
      _recordList = snapshot.docs.map((doc) => Record.fromMap(doc.data() as Map<String ,dynamic>)).toList();
    });
  }

  void _addExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Record'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(hintText: 'Purchase Date'),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      _dateController.text = date.toIso8601String().substring(0, 10);
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(hintText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _checkedBoxController,
                  decoration: InputDecoration(hintText: 'Checked Box'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter checked box';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(hintText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Record record = Record(
                    purchaseDate: DateTime.parse(_dateController.text),
                    description: _descriptionController.text,
                    amount: double.parse(_amountController.text),
                    checkedBox: _checkedBoxController.text == '1',
                    imageUrl: _imageUrlController.text,
                  );
                  await recordReference.add(record.toMap());
                  _fetchExpenses();
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _updateExpense(Record data) {
    _dateController.text = data.purchaseDate.toIso8601String().substring(0, 10);
    _descriptionController.text = data.description;
    _amountController.text = data.amount.toString();
    _checkedBoxController.text = data.checkedBox ? '1' :'0';
    _imageUrlController.text = data.imageUrl;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Record'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(hintText: 'Purchase Date'),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: data.purchaseDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      _dateController.text = date.toIso8601String().substring(0, 10);
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(hintText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _checkedBoxController,
                  decoration: InputDecoration(hintText: 'Checked Box'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter checked box';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(hintText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Record updatedRecord = Record(
                    purchaseDate: DateTime.parse(_dateController.text),
                    description: _descriptionController.text,
                    amount: double.parse(_amountController.text),
                    checkedBox: _checkedBoxController.text == '1',
                    imageUrl: _imageUrlController.text,
                  );
                  await recordReference.doc(data.purchaseDate.toString()).update(updatedRecord.toMap());
                  _fetchExpenses();
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteExpense(Record record) async {
    await recordReference.doc(record.purchaseDate.toString()).delete();
    _fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Record",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 2),
              // MonthListItem(
              //     month: ,
              //     records: _recordList,
              // )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addExpense,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}