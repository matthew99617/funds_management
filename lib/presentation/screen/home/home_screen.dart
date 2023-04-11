import 'package:flutter/material.dart';
import 'package:funds_management/presentation/screen/home/component/to_do_list.dart';
import 'package:funds_management/shared/bottomNav.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../model/notes.dart';
import '../../../shared/icons_data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<Notes> toDoList = [
    Notes(title: 'What to do 1', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 24), endDate: DateTime.utc(2023, 02, 24)),
    Notes(title: 'What to do 6', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 01), endDate: DateTime.utc(2023, 02, 06)),
    Notes(title: 'What to do 5', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 27), endDate: DateTime.utc(2023, 02, 28)),
    Notes(title: 'What to do 3', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 17), endDate: DateTime.utc(2023, 02, 24)),
    Notes(title: 'What to do 4', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 04), endDate: DateTime.utc(2023, 02, 24)),
    Notes(title: 'What to do 7', notes: 'Testing 123', startDate: DateTime.utc(2023, 03, 04), endDate: DateTime.utc(2023, 03, 18)),
    Notes(title: 'What to do 8', notes: 'Testing 123', startDate: DateTime.utc(2023, 05, 04), endDate: DateTime.utc(2023, 05, 18)),
    Notes(title: 'What to do 9', notes: 'Testing 123', startDate: DateTime.utc(2023, 09, 04), endDate: DateTime.utc(2023, 09, 18)),
    Notes(title: 'What to do 10', notes: 'Testing 123', startDate: DateTime.utc(2023, 02, 04), endDate: DateTime.utc(2023, 02, 18)),

  ];

  static List<Notes> sortByDay(List<Notes> dates) {
    dates.sort((a, b) => a.startDate.compareTo(b.startDate));
    return dates;
  }

  static List<Notes> filterDataByCurrentMonth(List<Notes> dataList) {
    // final now = DateTime.now();
    final now = DateTime.utc(2023, 02, 01);
    return dataList.where((data) =>
    data.startDate.month == now.month && data.startDate.year == now.year).toList();
  }

  static List<Notes> filterMonthList = filterDataByCurrentMonth(toDoList);
  static List<Notes> display_toDoList = sortByDay(filterMonthList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
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
                        "Forward Plans",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(scanIcon),
                        iconSize: 30,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: <Widget> [
                      //     Icon(scanIcon)
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 2),
                // Container(
                //   height: MediaQuery.of(context).size.height*0.7,
                //   width: MediaQuery.of(context).size.width,
                //   alignment: Alignment.center,
                //   child:
                //   Center(
                //       child: Text(
                //         "123",
                //         /// Todo
                //       )
                //   )
                // ),
                ListToDo(toDoList: display_toDoList),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav());
  }
}
