import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> _daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          controller: _scrollController,
          itemCount: 12,
          itemBuilder: (context, index) {
            DateTime date = DateTime(DateTime.now().year, index + 1, 1);
            return _buildMonthCalendar(date);
          },
        ),
    );
  }

  Widget _buildMonthCalendar(DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              DateFormat.yMMM().format(date),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 1,
          children: _buildCalendarDays(date),
        ),
      ],
    );
  }

  List<Widget> _buildCalendarDays(DateTime date) {
    List<Widget> days = [];

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    for (int i = 0; i < 7; i++) {
      days.add(
        Center(
          child: Text(
              _daysOfWeek[i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
          ),
        )
      );
    }

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime dateInMonth = DateTime(date.year, date.month, i);
      days.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                i.toString(),
                // style: TextStyle(
                //   color: dateInMonth == DateTime.now() ? Colors.blue : Colors.black,
                // ),
              ),
            ),
          ),
        ),
      );
    }

    // Add blank cells for days after the last day of the month
    int numBlankCells = (7 - (daysInMonth + weekdayOfFirstDay - 1) % 7) % 7;
    for (int i = 0; i < numBlankCells; i++) {
      days.add(Container());
    }

    return days;
  }
}