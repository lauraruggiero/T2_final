import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Holiday>> fetchInfo() async {
  Uri url = Uri.parse('https://date.nager.at/api/v3/PublicHolidays/2022/BR');
  final response = await http.get(url);
  List<Holiday> holidayList = [];
  if (response.statusCode == 200) {
    //print(json.decode(response.body));
    for (var i in json.decode(response.body)) {
      holidayList.add(Holiday.fromJson(i));
      //print(Holiday.fromJson(i));
    }
    return holidayList;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Holiday {
  final String date;
  final String name;

  Holiday({@required this.date, @required this.name});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      date: json['date'],
      name: json['localName'],
    );
  }
}

class MyHolidayList extends StatelessWidget {
  final Future<List<Holiday>> holidayList;

  MyHolidayList({@required this.holidayList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays in 2022'),
      ),
      body: Center(
        child: FutureBuilder<List<Holiday>>(
          future: holidayList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Holiday> holidayList = snapshot.data;
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var text = holidayList[index].name;
                    var day = holidayList[index].date;
                    //snapshot.data != null ? snapshot.data[index].name : '';
                    return ListTile(
                      //leading: Text(snapshot.data[index].id.toString()),
                      title: Text(text),
                      subtitle:
                          Text(day.substring(8) + '/' + day.substring(5, 7)),
                    );
                  },
                  itemCount: snapshot.data?.length);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
