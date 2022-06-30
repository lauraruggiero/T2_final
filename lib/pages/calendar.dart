// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../bloc/event_bloc.dart';
import '../model/event.dart';
import '../shared/events_display.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0)
      .toUtc();
  DateTime _selectedDay = DateTime.utc(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 0, 0, 0)
      .toUtc();

  final EventBloc eventBloc = EventBloc();
  TimeOfDay selectedTime = TimeOfDay.now();

  //final String title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: eventBloc.getAllEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
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
                            eventBloc.getEventsForDay(selectedDay);
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
                        eventLoader: eventBloc.getEventsInCalendar, //
                      );
                    } else {
                      return loadingData();
                    }
                  }),
              //getEventsWidget()
              EventsDisplay(selectedDay: _selectedDay, eventBloc: eventBloc)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddEventSheet(context);
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        ));
  }

  void _showAddEventSheet(BuildContext context) {
    final _eventTitleController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(children: [
                              TextFormField(
                                controller: _eventTitleController,
                                textInputAction: TextInputAction.newline,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.w400),
                                autofocus: true,
                                decoration: const InputDecoration(
                                    //hintText: 'I have to...',
                                    labelText: 'New Event',
                                    labelStyle: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontWeight: FontWeight.w500)),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Empty description!';
                                  }
                                  return value.contains('')
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                              // TextFormField(
                              //   controller: _eventTitleController,
                              //   textInputAction: TextInputAction.newline,
                              //   maxLines: 1,
                              //   style: TextStyle(
                              //       fontSize: 21, fontWeight: FontWeight.w400),
                              //   autofocus: true,
                              //   decoration: const InputDecoration(
                              //       //hintText: 'I have to...',
                              //       labelText: 'Time',
                              //       labelStyle: TextStyle(
                              //           color: Colors.indigoAccent,
                              //           fontWeight: FontWeight.w500)),
                              //   validator: (String value) {
                              //     if (value.isEmpty) {
                              //       return 'Empty description!';
                              //     }
                              //     return value.contains('')
                              //         ? 'Do not use the @ char.'
                              //         : null;
                              //   },
                              // ),
                              //Text("time"),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newEvent = Event(
                                      title: _eventTitleController.value.text
                                          .trim(),
                                      date:
                                          _selectedDay /*,
                                      time: selectedTime*/
                                      );

                                  if (newEvent.title.isNotEmpty) {
                                    eventBloc.addEvent(
                                      newEvent,
                                      _selectedDay, /*selectedTime*/
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: Text("Choose Time"),
                      ),
                      Text("${selectedTime.hour}:${selectedTime.minute}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  Widget loadingData() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  dispose() {
    eventBloc.dispose();
    super.dispose();
  }
}
