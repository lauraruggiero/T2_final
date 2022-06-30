// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../bloc/event_bloc.dart';
import '../model/event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsDisplay extends StatelessWidget {
  EventsDisplay({Key key, this.selectedDay, this.eventBloc}) : super(key: key);

  final DateTime selectedDay;
  final EventBloc eventBloc;
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return getEventsWidget();
    //return Text(selectedDay.toString());
  }

  Widget getEventsWidget() {
    return StreamBuilder(
      stream: eventBloc.events,
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        return getEventCardWidget(snapshot);
      },
    );
  }

  Widget getEventCardWidget(AsyncSnapshot<List<Event>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? Expanded(
              child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Event event = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).deleting,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    eventBloc.deleteEventById(event.eventId, selectedDay);
                    // setState(() {});
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(event),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // subtitle: Text(
                        //   event.time.toString(),
                        //   style: TextStyle(
                        //     fontSize: 16.5,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      )),
                );
                return dismissibleCard;
              },
            ))
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noEventMessageWidget(),
            ));
    } else {
      return Center(
        child: loadingData(),
      );
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

  Widget noEventMessageWidget() {
    return Container(
      child: Text(
        "No events scheduled today :)",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
