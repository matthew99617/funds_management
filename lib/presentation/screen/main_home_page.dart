import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/presentation/router/router.gr.dart';

import '../../firebase/FireStoreDataBase.dart';
import '../../model/notes.dart';
import '../../model/retrieve_data_with_id_notes.dart';
import '../../shared/bottomNav.dart';
import '../../shared/share_preference_helper.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  static List<Notes> savedList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FireStoreDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            savedList.clear();
            var dataList = (snapshot.data as List)
                .map((item) => item as RetrieveDataWithID).toList();
            for (var result in dataList) {
              var toDoList = Notes(
                id: result.id,
                title: result.notes.title,
                notes: result.notes.notes,
                startDate: result.notes.startDate,
                endDate: result.notes.endDate,
              );

              /**
               *  Remember You have Filtering the Data, Just CURRENT MONTH only
               */

              savedList.add(toDoList);
            }
            final String encodeData = Notes.encode(savedList);
            SharePreferenceHelper.saveListData(encodeData);
            return AutoTabsScaffold(
              routes: [
                HomeRouter(),
                CalendarRouter(),
                RecordRouter(),
                SettingRouter(),
              ],
              bottomNavigationBuilder: (context, tabsRouter) => BottomNav(
                tabsRouter: tabsRouter,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(child: Text("Something went wrong"));
        }
    );
  }
}
