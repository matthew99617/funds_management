import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/shared/colors.dart';
import 'package:intl/intl.dart';

import '../../../../shared/icons_data.dart';

class CalendarBottomSheet extends StatefulWidget {

  final ScrollController scrollController = ScrollController();

  final String? title;
  final String? notes;
  final DateTime? startDate;
  final DateTime? endDate;

  CalendarBottomSheet({Key? key, this.title, this.notes, this.startDate, this.endDate}) : super(key: key);

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {

  final myControllerTitle = TextEditingController();
  final myControllerDescription = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController dateInputStartDate = TextEditingController();
  TextEditingController dateInputEndDate = TextEditingController();


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
      dateInputStartDate.text = widget.startDate.toString();
    }

    if (widget.endDate == null){
      dateInputEndDate.text = "";
    } else {
      dateInputEndDate.text = widget.endDate.toString();
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
    return Container(
      padding: EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Add Event',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
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
              autofocus: true,
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
            TextField(
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
            ),
            TextField(
              controller: dateInputEndDate, //editing controller of this TextField
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today,), //icon of text field
                labelText: "End Date", //label text of field
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(dateInputStartDate.text),
                  firstDate: DateTime.parse(dateInputStartDate.text),
                  lastDate: lastYear,
                );

                if(pickedDate != null){
                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dateInputEndDate.text = formattedDate; //set output date to TextField value.
                  });
                }else{
                  print("Date is not selected");
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Submit"),
                      ),
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
