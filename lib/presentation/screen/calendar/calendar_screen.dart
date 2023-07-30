import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:funds_management/firebase/FireStoreDataBase.dart';
import 'package:funds_management/model/notes_data_source.dart';
import 'package:funds_management/presentation/screen/calendar/component/calendar_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../model/notes.dart';
import '../../../shared/share_preference_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static bool havePermissions = false;
  static List<Notes> savedList = [];
  bool isOpen = false;

  DateTime today = DateTime.now();
  DateTime firstYear = DateTime.utc(DateTime.now().year.toInt() - 5 , 12, 31);
  DateTime lastYear = DateTime.utc(DateTime.now().year.toInt() + 5 , 12, 31);

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment ||
        calendarTapDetails.targetElement == CalendarElement.agenda) {
      Notes notes = calendarTapDetails.appointments?[0];
      showModalBottomSheet<void>(
          useRootNavigator: true,
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45.0),
              )
          ),
          builder: (context) {
            return CalendarBottomSheet(
              id: notes.id,
              title: notes.title,
              notes: notes.notes,
              startDate: notes.startDate,
              endDate: notes.endDate,
            );
          },
      ).whenComplete(() => loadData());
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async{
    final dataStr = await SharePreferenceHelper.getListData();
    final permission = await SharePreferenceHelper.getPermission();
    setState(() {
      print(permission);
      havePermissions = permission;
      savedList = Notes.decode(dataStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: content(),
      floatingActionButton: havePermissions ? FloatingActionButton.extended(
        onPressed: () => {
          showModalBottomSheet<void>(
            useRootNavigator: true,
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45.0),
              )
            ),
            builder: (context) {
              return CalendarBottomSheet();
            }
          ).whenComplete(() => loadData(),),
        },
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ) : FloatingActionButton(
        onPressed: loadData,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget content(){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: NotesDataSource(savedList),
          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            appointmentDisplayCount: 4,
          ),
          onTap: havePermissions ? calendarTapped : null,
          backgroundColor: Colors.grey,
          firstDayOfWeek: 7,
          showDatePickerButton: true,
          ),
      )
    );
  }
}