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
  TextEditingController dateInput = TextEditingController();

  DateTime firstYear = DateTime.utc(DateTime.now().year.toInt() - 1 , 12, 31);
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
      dateInput.text = "";
    } else {
      dateInput.text = widget.startDate.toString();
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
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              controller: myControllerTitle,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                ),
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
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
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
              controller: dateInput, //editing controller of this TextField
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Start Date", //label text of field
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
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
            ),
            TextField(
              controller: dateInput, //editing controller of this TextField
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today,), //icon of text field
                labelText: "End Date", //label text of field
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
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
            )
          ],
        ),
      ),
    );
  }
}
