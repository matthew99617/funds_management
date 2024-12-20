import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../model/notes.dart';

class ListToDo extends StatefulWidget {
  final List<Notes> toDoList;

  const ListToDo({super.key, required this.toDoList});

  @override
  State<ListToDo> createState() => _ListToDoState();
}

class _ListToDoState extends State<ListToDo> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        alignment: Alignment.center,
        child: widget.toDoList.length == 0
            ? Center(
          child: Text(
            "No Forward Plan",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ) : Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            itemCount: widget.toDoList.length,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildToDoItem(
                widget.toDoList[index].title,
                widget.toDoList[index].startDate,
                widget.toDoList[index].endDate,
                _calDateStatus(widget.toDoList[index].startDate,
                    widget.toDoList[index].endDate),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              // color: Colors.black,
              thickness: 2,
            ),
          ),
        ),
      ),
    );
  }

  // List Product
  Widget _buildToDoItem(String title, DateTime startDate, DateTime endDate, String status,) {
    return status == "Completed" ?
    Opacity(
      opacity: 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            print("123");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      title,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Montserret',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Text(
                    status,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Montserret',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date: ',
                    style: TextStyle(
                      fontFamily: 'Montserret',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${startDate.day}-${startDate.month}-${startDate
                        .year} To ${endDate.day}-${endDate.month}-${endDate
                        .year}',
                    style: TextStyle(
                        fontFamily: 'Montserret',
                        fontSize: 15,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ): Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          print("123");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    title,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Montserret',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Text(
                  status,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Montserret',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Date: ',
                  style: TextStyle(
                    fontFamily: 'Montserret',
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${startDate.day}-${startDate.month}-${startDate
                      .year} To ${endDate.day}-${endDate.month}-${endDate
                      .year}',
                  style: TextStyle(
                      fontFamily: 'Montserret',
                      fontSize: 15,
                      decoration: TextDecoration.underline
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Calculate the DayStatus
  String _calDateStatus(DateTime startDay, DateTime endDay) {
    final now = DateTime.utc(2023, 02, 05); // Get Today Date
    final tmr = now.add(Duration(days: 1)); // Get the Day of Tmr
    if (isInRange(now, startDay, endDay)) {
      if (now.day == endDay.day) {
        return "Last Day";
      } else {
        return "Today";
      }
    } else if (tmr.day == startDay.day) {
      return "Tomorrow";
    } else if (endDay.isBefore(now)) {
      return "Completed";
    }
    return "";
  }

  // Check the Date isInRange or not
  bool isInRange(DateTime now, DateTime start, DateTime end) {
    return now.isAfter(start.subtract(const Duration(days: 1))) &&
        now.isBefore(end.add(const Duration(days: 1)));
  }

}
