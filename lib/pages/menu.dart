import 'dart:async';
import 'dart:convert';

import 'package:calendar_app/pages/test_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'tryout.dart';
import 'checklist.dart';
import 'holidays_list.dart';
import 'test_db.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  // _selectedDay = selectedDay;
                  // _focusedDay = focusedDay; // update '_focusedDay' here as well
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Checklist'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyList()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Tryout'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CalendarTest()),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Holidays'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MyHolidayList(holidayList: fetchInfo())),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Test DB'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyEventsList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
