import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/model/record.dart';

import '../../../model/basic_month.dart';
import '../../../shared/share_preference_helper.dart';
import 'component/record_bottom_sheet.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  final ScrollController scrollController = ScrollController();

  static List<double> totalAmount = [];
  static List<Record> _recordList = [];
  static List<DateTime> previousSixMonth = [];
  static List<BasicMonth> basicMonth = [];
  static String currentTotalAmount = "";
  static bool havePermissions = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async{
    final dataStr = await SharePreferenceHelper.getRecordData();
    final permission = await SharePreferenceHelper.getPermission();

    setState(() {
      havePermissions = permission;
      _recordList = Record.decode(dataStr);
      getSixMonthAgo();
    });
  }

  void getSixMonthAgo() {
    basicMonth.clear();
    previousSixMonth.clear();
    var now = DateTime.now();
    for (int i = 0; i < 6; i++) {
      final previousMonth = DateTime(now.year, now.month - i, 1);

      // 如果當前月份為1月或3月，並且上一個月份為12月或2月，需要進行特殊處理
      if ((now.month == 1 || now.month == 3) && previousMonth.month == 12 - i) {
        previousMonth.subtract(Duration(days: 365));
        previousSixMonth.add(previousMonth);
      } else {
        previousSixMonth.add(previousMonth);
      }
    }

    setState(() {
      Decimal temp = Decimal.parse("0");

      previousSixMonth.forEach((dateTime) {
        for (var i = 0; i < _recordList.length; i++){
          if (dateTime.month == _recordList[i].purchaseDate.month){
            basicMonth.add(
              BasicMonth(
                month: dateTime.month,
                record: _recordList[i],
              ),
            );
          }
        }
      });
      for (int i = 0; i < basicMonth.length; i++){
        if (basicMonth[i].record.isPaid){
          temp += Decimal.parse("${basicMonth[i].record.amount}");
        }
      }
      currentTotalAmount = temp.toString();
    });
  }

  static List<Record> sortByDay(List<Record> dates) {
    dates.sort((a, b) {
      int startComparison = b.purchaseDate.compareTo(a.purchaseDate);
      return startComparison;
    });

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                      "Record",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    currentTotalAmount.contains("-")
                        ? Text(
                      "Total: -\$${stringToOnlyAmount(currentTotalAmount)}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ) : Text(
                      "Total: \$${stringToOnlyAmount(currentTotalAmount)}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 2),
              /**
               *  ExpansionTile
               */

              buildList()
            ],
          ),
        ),
        floatingActionButton: havePermissions ? FloatingActionButton(
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
                  return RecordBottomSheet();
                }
            ).whenComplete(() => loadData(),),
          },
          child: Icon(Icons.add),
        ) : null
      ),
    );
  }

  Widget buildList(){
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: previousSixMonth.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            // change to english
            title: Text(
              changeMonthFromNumberToString(previousSixMonth[index].month),
            ),
            leading:
            calculateCurrentMonthAmount(previousSixMonth[index].month) < 0
                ? Text(
                  "-\$${toOnlyAmount(calculateCurrentMonthAmount(previousSixMonth[index].month))}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
            ) : Text(
              "\$${toOnlyAmount(calculateCurrentMonthAmount(previousSixMonth[index].month))}",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.lightGreen,
              ),
            ),
            children: [
              buildRecordList(previousSixMonth[index].month)
            ],
          );
        },
      ),
    );
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

  Widget buildRecordList(int month){
    List<Record> currentMonth = [];
    for (var i = 0; i < basicMonth.length; i++){
      if (basicMonth[i].month == month){
        currentMonth.add(basicMonth[i].record);
      }
    }
    currentMonth = sortByDay(currentMonth);
    return currentMonth.length == 0 ?
    Container(
      height: MediaQuery.of(context).size.height *0.2,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text("No Record in ${changeMonthFromNumberToString(month)}"),
      ),
    ) : ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: currentMonth.length,
      itemBuilder: (BuildContext context, int index) {
         return Container(
           padding: EdgeInsets.all(16.0),
           child: InkWell(
             onTap: () {
               if (havePermissions) {
                 onClickList(currentMonth[index]);
               }
             },
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Text(
                         "${currentMonth[index].description}",
                         style: TextStyle(
                           fontSize: 24.0,
                           fontWeight: FontWeight.bold,
                         )
                     ),
                   ],
                 ),
                 SizedBox(height: 8.0),
                 currentMonth[index].amount < 0
                     ? Text('Amount: -\$${toOnlyAmount(currentMonth[index].amount)}',
                   style: TextStyle(
                     fontSize: 16.0,
                     fontWeight: FontWeight.normal,
                     color: Colors.red,
                   ),
                 ) : Text('Amount: \$${currentMonth[index].amount}',
                   style: TextStyle(
                     fontSize: 16.0,
                     fontWeight: FontWeight.normal,
                     color: Colors.lightGreen,
                   ),
                 ),
                 SizedBox(height: 8.0),
                 Text('Purchase Date: ${toFormat(currentMonth[index].purchaseDate.year, currentMonth[index].purchaseDate.month, currentMonth[index].purchaseDate.day)}',
                     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
                 SizedBox(height: 8.0,),
                 Row(
                   children: <Widget>[
                     Text(
                       "Paid?",
                       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                     ),
                     Checkbox(
                       value: currentMonth[index].isPaid,
                       onChanged: null,
                       checkColor: Colors.blue,
                       fillColor: null,
                     )
                   ],
                 ),
                 SizedBox(height: 8.0,),
                 Text(
                   "Remark: ${currentMonth[index].remark}",
                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                 ),
               ],
             ),
           ),
         );

      },
      separatorBuilder: (BuildContext context, int index) =>
      const Divider(
        // color: Colors.black,
        thickness: 2,
      ),
    );
  }

  String toOnlyAmount(double amount){
    return amount.toString().replaceAll("-", "");
  }

  String stringToOnlyAmount(String amount){
    return amount.replaceAll("-", "");
  }

  String toFormat(int yy, int mm, int dd){
    return "$yy/$mm/$dd";
  }

  double calculateCurrentMonthAmount(int month){
    late Decimal currentMonthAmount = Decimal.parse("0");
    for (int i = 0; i < basicMonth.length; i++){
      if (basicMonth[i].record.isPaid){
        if (basicMonth[i].month == month){
          currentMonthAmount += Decimal.parse('${basicMonth[i].record.amount}');
        }
      }
    }

    totalAmount.add(currentMonthAmount.toDouble());
    if (currentMonthAmount.toDouble() < 0){
      return currentMonthAmount.toDouble();
    } else {
      return currentMonthAmount.toDouble();
    }
  }

  void calculateCurrentTotalAmount() {
    setState(() {
      totalAmount.clear();
      Decimal calculateTotalAmount = Decimal.parse("0");
      for (int i = 0; i < totalAmount.length; i++) {
        calculateTotalAmount += Decimal.parse("${totalAmount[i]}");
      }
      print(calculateTotalAmount);
      currentTotalAmount = toOnlyAmount(calculateTotalAmount.toDouble());
    });
  }

  void onClickList(Record record){
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
        return RecordBottomSheet(
          id: record.id,
          description: record.description,
          amount: record.amount,
          purchaseDate: record.purchaseDate,
          isPaid: record.isPaid,
          remark: record.remark,
        );
      },
    ).whenComplete(() => loadData());
  }
}