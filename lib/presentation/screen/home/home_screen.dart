import 'package:flutter/material.dart';
import 'package:funds_management/shared/bottomNav.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../shared/icons_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController scrollController = ScrollController();

  List _elements = [
    {'name': 'John', 'group': 'Team A', 'note': 'Testing 123', 'date': '24-02-2023'},
    {'name': 'Will', 'group': 'Team B', 'note': 'Testing 1234', 'date': '23-04-2023'},
    {'name': 'Beth', 'group': 'Team A', 'note': 'Testing 1235', 'date': '01-02-2023'},
    {'name': 'Miranda', 'group': 'Team B', 'note': 'Testing 1236', 'date': '31-05-2023'},
    {'name': 'Mike', 'group': 'Team C', 'note': 'Testing 1237', 'date': '15-03-2023'},
    {'name': 'Danny', 'group': 'Team C', 'note': 'Testing 1238', 'date': '29-01-2023'},
  ];

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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
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
                      onPressed: (){

                      },
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
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  "123"
                  /// Todo
                )
                // Scrollbar(
                //   thumbVisibility: true,
                //   controller: scrollController,
                //   child: ListView.separated(
                //     controller: scrollController,
                //     scrollDirection: Axis.vertical,
                //     itemCount: widget.listItem.length,
                //     primary: false,
                //     itemBuilder: (BuildContext context, int index) {
                //       // return _buildProductItem(
                //       //   _changeIcon(widget.listItem[index].type),
                //       //   widget.listItem[index].titles,
                //       //   _calExpiryDay(widget.listItem[index].dateOfPurchasing, widget.listItem[index].validYear),
                //       //   // widget.listItem[index].expireState,
                //       // );
                //     },
                //     separatorBuilder: (BuildContext context, int index) =>
                //     const SizedBox(height: 2,)
                //   ),
                // ),
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav()
    );
  }
}
