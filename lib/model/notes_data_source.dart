import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:funds_management/model/notes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class NotesDataSource extends CalendarDataSource {

  NotesDataSource(List<Notes> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getNotesData(index).startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return _getNotesData(index).endDate;
  }

  @override
  String getSubject(int index) {
    return _getNotesData(index).title;
  }

  @override
  Color getColor(int index) {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  bool isAllDay(int index) {
    return true;
  }

  Notes _getNotesData(int index) {
    final dynamic notes = appointments![index];
    late final Notes notesData;
    if (notes is Notes) {
      notesData = notes;
    }

    return notesData;
  }
}