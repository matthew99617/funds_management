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

  @override
  void dispose() {
    myControllerTitle.dispose();
    myControllerDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

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
      color: darkBackground,
      padding: EdgeInsets.all(20),
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
            // DateTimeFormField(
            //   dateFormat: DateFormat("yyyy-mm-dd"),
            //   onDateSelected: (DateTime value){
            //     print(value);
            //   },
            //   firstDate: widget.startDate != null ? widget.startDate!.toUtc().add(const Duration(days: 10))
            //       : DateTime.now().add(const Duration(days: 10)),
            //   lastDate: widget.startDate != null ? widget.startDate!.toUtc().add(const Duration(days: 40))
            //       : DateTime.now().add(const Duration(days: 40)),
            //   initialDate: widget.startDate != null ? widget.startDate!.toUtc().add(const Duration(days: 20))
            //       : DateTime.now().add(const Duration(days: 20)),
            //   decoration: InputDecoration(
            //     prefixIcon: Icon(dateIcon),
            //     labelText: 'Start Date',
            //     hintText: widget.startDate != null ? "${widget.startDate!.year}-${widget.startDate!.month}-${widget.startDate!.day}"
            //         : "Please Enter the StartDate",
            //   ),
            //   autovalidateMode: AutovalidateMode.always,
            //   validator: (DateTime? e) =>
            //   (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
            // ),
            DateTimeFormField(
              onDateSelected: (DateTime value){
                print(value);
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
