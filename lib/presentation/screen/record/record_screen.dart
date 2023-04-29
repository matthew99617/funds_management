import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                  "Record"
              )
          ),
        )
    );
  }
}