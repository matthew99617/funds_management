import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:funds_management/model/notes_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../model/notes.dart';
import '../../../shared/share_preference_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final ScrollController _scrollController = ScrollController();
  static List<Notes> savedList = [];
  Map<DateTime, List<Notes>>? _selectedEvent = null;

  DateTime today = DateTime.now();
  DateTime firstYear = DateTime.utc(DateTime.now().year.toInt() - 5 , 12, 31);
  DateTime lastYear = DateTime.utc(DateTime.now().year.toInt() + 5 , 12, 31);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment ||
        calendarTapDetails.targetElement == CalendarElement.agenda) {
      Notes notes = calendarTapDetails.appointments![0];
      print('123: ${notes.title}');
    }
  }

  Future loadData() async{
    final dataStr = await SharePreferenceHelper.getListData();
    setState(() {
      savedList = Notes.decode(dataStr);
    });
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  void _onDaySelected(DateTime day, DateTime focusedDate){
    today = day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>{
          // BottomSheet(
          //   onClosing: onClosing,
          //   builder: builder,
          // ),
        },
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget content(){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // child: Column(
        //   children: <Widget>[
        //     Text("Selected Day = ${today.toString().split(" ")[0]}"),
        //     Container(
        //       child: SfCalendar(
        //         view: CalendarView.month,
        //         dataSource: NotesDataSource(savedList),
        //         monthViewSettings: const MonthViewSettings(
        //           showAgenda: true,
        //         ),
        //         viewNavigationMode: ViewNavigationMode.snap,
        //         firstDayOfWeek: 1,
        //       ),
        //     ),
        //     // SizedBox(height: 10),
        //     // PlansTitleGroupList(),
        //   ],
        // ),
        child: SfCalendar(
            view: CalendarView.month,
            dataSource: NotesDataSource(savedList),
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              appointmentDisplayCount: 2,
            ),
            onTap: calendarTapped,
            viewNavigationMode: ViewNavigationMode.snap,
            backgroundColor: Colors.grey,
            firstDayOfWeek: 1,
          showDatePickerButton: true,
          allowViewNavigation: true,
          ),
      )
    );
  }
}