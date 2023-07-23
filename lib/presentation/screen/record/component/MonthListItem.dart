import 'package:flutter/material.dart';

import '../../../../model/record.dart';

class MonthListItem extends StatefulWidget {
  final DateTime month;
  final List<Record> records;

  MonthListItem({required this.month, required this.records});

  @override
  _MonthListItemState createState() => _MonthListItemState();
}

class _MonthListItemState extends State<MonthListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = widget.month.year == now.year && widget.month.month == now.month;
    final isHalfYearAgo = widget.month.isBefore(now.subtract(Duration(days: 180)));
    final showMonth = widget.month.month.toString().padLeft(2, '0');
    final showYear = widget.month.year;

    final items = widget.records
        .where((record) =>
    record.purchaseDate.year == widget.month.year &&
        record.purchaseDate.month == widget.month.month)
        .toList();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$showMonth/$showYear',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isCurrentMonth ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isExpanded ? items.length * 56.0 : 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text('${item.description} - ${item.amount}'),
              );
            },
          ),
        ),
      ],
    );
  }
}