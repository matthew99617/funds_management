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
    return dataList
        .where((data) =>
            data.startDate.month == now.month &&
            data.startDate.year == now.year)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
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
                        "Forward Plans(${DateTime.now().month})",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      IconButton(
                        icon: Icon(scanIcon),
                        iconSize: 30,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                      ),
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
