import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//import '../utils.dart';
import '../model/event.dart';

class CalendarTest extends StatefulWidget {
  @override
  _CalendarTestState createState() => _CalendarTestState();
}

class _CalendarTestState extends State<CalendarTest> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime _selectedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Test'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            //firstDay: kFirstDay,
            //lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          ..._getEventsForDay(_selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text("Add Event"),
                    content: TextFormField(controller: _eventController),
                    actions: [
                      TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            if (_eventController.text.isEmpty) {
                              //Navigator.pop(context);
                              //return;
                            } else {
                              if (selectedEvents[_selectedDay] != null) {
                                selectedEvents[_selectedDay]!
                                    .add(Event(title: _eventController.text));
                              } else {
                                selectedEvents[_selectedDay] = [
                                  Event(title: _eventController.text)
                                ];
                              }
                            }
                            Navigator.pop(context);
                            _eventController.clear();
                            setState(() {});
                            return;
                          })
                    ])),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
