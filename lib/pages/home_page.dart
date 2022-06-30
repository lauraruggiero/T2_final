import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'calendar.dart';
import 'holidays_list.dart';
import 'todolist.dart';
import 'login_page.dart';
import '../bloc/event_bloc.dart';
import '../shared/events_display.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  @override
  Widget build(BuildContext context) {
    //showNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homePageTitle),
      ),
      drawer: Drawer(
          child: ListView(children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.rectangle,
            ),
            padding: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('MySchedule App',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            )),
        Padding(
            padding: EdgeInsets.all(12),
            child: ListTile(
              title: Text(AppLocalizations.of(context).logout),
              //Text(AppLocalizations.of(context).logout),
              onTap: () {
                sharedPreferences.remove('email');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )),
      ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(AppLocalizations.of(context).todaysEvents,
                    style: TextStyle(fontSize: 20))),
            Container(
                height: 400,
                child: EventsDisplay(
                    selectedDay: DateTime.utc(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day, 0, 0, 0)
                        .toUtc(),
                    eventBloc: EventBloc())),
            const SizedBox(height: 20.0),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text("Menu", style: TextStyle(fontSize: 20))),
            ElevatedButton(
              child: Text(AppLocalizations.of(context).todoButton),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TodoList()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text(AppLocalizations.of(context).calendarButton),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Calendar()),
              ).then((value) => setState(() {})),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text(AppLocalizations.of(context).holidaysButton),
              //style: ,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MyHolidayList(holidayList: fetchInfo())),
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }

  // Future<void> _showNotification() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   print("show notification function");
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your channel id', 'your channel name',
  //       importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'plain title', 'plain body', platformChannelSpecifics,
  //       payload: 'item x');
  // }
}
