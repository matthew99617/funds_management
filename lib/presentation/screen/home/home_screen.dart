import 'dart:core';
import 'package:flutter/material.dart';
import 'package:funds_management/firebase/FireStoreDataBase.dart';
import 'package:funds_management/model/retrieve_data_with_id_notes.dart';
import 'package:funds_management/presentation/screen/home/component/to_do_list.dart';

import '../../../model/notes.dart';
import '../../../shared/icons_data.dart';
import '../../../shared/share_preference_helper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<Notes> savedList = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async{
    final dataStr = await SharePreferenceHelper.getListData();
    setState(() {
      savedList = Notes.decode(dataStr);
    });
  }

  static List<Notes> sortByDay(List<Notes> dates) {
    dates.sort((a, b) {
      int startComparison = a.startDate.compareTo(b.startDate);
      if (startComparison == 0) {
        return a.endDate.compareTo(b.endDate);
      }
      return startComparison;
    });

    return dates;
  }

  static List<Notes> filterDataByCurrentMonth(List<Notes> dataList) {
    final now = DateTime.now();

    // 遍歷 datalist，找到在 start date 前 7 天內和 end date 範圍內的數據。
    final filteredData = dataList.where((item) {

      // 如果日期在 start date 前 30 天內或在 end date 範圍內，則保留該數據。
      return now.isAfter(item.startDate.subtract(Duration(days: 30))) && now.isBefore(item.endDate.add(Duration(days: 1)));
    }).toList();

    return filteredData;
  }

  String changeMonthFromNumberToString(int month){
    switch(month){
      case 1: return "January";
      case 2: return "February";
      case 3: return "March";
      case 4: return "April";
      case 5: return "May";
      case 6: return "June";
      case 7: return "July";
      case 8: return "August";
      case 9: return "September";
      case 10: return "October";
      case 11: return "November";
      case 12: return "December";
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: loadData,
        child: const Icon(Icons.refresh),
      ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        "${changeMonthFromNumberToString(DateTime.now().month)}",
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(height: 2),
                ListToDo(toDoList: sortByDay(filterDataByCurrentMonth(savedList))),
              ],
            ),
          ),
        )
    );
  }
}
