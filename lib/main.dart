// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'pages/login_page.dart';
import 'l10n/l10n.dart';

void main() {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: onSelectNotification);

  runApp(MyApp());
  initializeDateFormatting();
  //initializeDateFormatting().then((_) => runApp(MyApp()));

  //await _showNotification(flutterLocalNotificationsPlugin);
}

class MyApp extends StatelessWidget {
  static final String title = "MyCalendar App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          fontFamily: 'Nexa',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          )),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Future<void> _showNotification(flutterLocalNotificationsPlugin) async {
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

// Future<void> onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   // await showDialog(
//   //   //context: context,
//   //   builder: (BuildContext context) => CupertinoAlertDialog(
//   //     title: Text(title),
//   //     content: Text(body),
//   //     actions: [
//   //       CupertinoDialogAction(
//   //         isDefaultAction: true,
//   //         child: Text('Ok'),
//   //         onPressed: () async {
//   //           Navigator.of(context, rootNavigator: true).pop();
//   //           await Navigator.push(
//   //             context,
//   //             MaterialPageRoute(
//   //               builder: (context) => SecondScreen(payload),
//   //             ),
//   //           );
//   //         },
//   //       )
//   //     ],
//   //   ),
//   //)
// }

// Future<void> onSelectNotification(String payload) async {
//   if (payload != null) {
//     debugPrint('notification payload: ' + payload);
//   }

// await Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
// );
//}