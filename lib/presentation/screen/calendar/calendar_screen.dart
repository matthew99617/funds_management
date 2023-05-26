import 'package:flutter/material.dart';
import 'package:funds_management/presentation/screen/calendar/component/plans_titile_group_list.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final ScrollController _scrollController = ScrollController();

  DateTime today = DateTime.now();
  DateTime firstYear = DateTime.utc(DateTime.now().year.toInt() - 5 , 12, 31);
  DateTime lastYear = DateTime.utc(DateTime.now().year.toInt() + 5 , 12, 31);

  void _onDaySelected(DateTime day, DateTime focusedDate){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: content(),
    );
  }

  Widget content(){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Text("Selected Day = ${today.toString().split(" ")[0]}"),
            Container(
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: firstYear,
                lastDay: lastYear,
                onDaySelected: _onDaySelected,
              ),
            ),
            SizedBox(height: 10),
            PlansTitleGroupList(),
          ],
        ),
      )
    );
  }
}