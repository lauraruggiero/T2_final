import 'package:flutter/material.dart';
import '../database.dart';
import '../model/event.dart';

class MyEventsList extends StatefulWidget {
  @override
  _MyEventsListState createState() => _MyEventsListState();
}

class _MyEventsListState extends State<MyEventsList> {
  late Future<List<Event>> eventsList = DBProvider.db.getEventsForUser(1);

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Event>>(
        future: DBProvider.db.getEventsForUser(1),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Event item = snapshot.data![index];
                return ListTile(
                  title: Text(item.title),
                  leading: Text(item.eventId.toString()),
                );
              },
            );
          } else {
            return Text("${snapshot.error}");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Event eventTest = new Event(title: "test", userId: 1);
          await DBProvider.db.newEvent(eventTest);
          setState(() {});
        },
      ),
    );
  }
}
