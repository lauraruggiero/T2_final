import 'package:flutter/material.dart';

String value = "";

class MyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyListState();
  }
}

class _MyListState extends State<MyList> {
  List<String> _texts = ['Homework'];
  final _controller = TextEditingController();
  List<bool> _isChecked = [false];

  @override
  void initState() {
    super.initState();
    // _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("To do list"),
        ),
        body: Column(children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "What do we have to do today?",
                ),
                controller: _controller,
              )),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: RaisedButton(
                // child: Text(
                //   'Add task',
                //   style: TextStyle(fontSize: 15),
                // ),
                child: Icon(Icons.add),
                highlightColor: Colors.deepOrange,
                onPressed: () {
                  setState(() {
                    _texts.add(_controller.text);
                    _isChecked.add(false);
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _texts.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(_texts[index]),
                value: _isChecked[index],
                onChanged: (val) {
                  setState(
                    () {
                      _isChecked[index] = val!;
                    },
                  );
                },
              );
            },
          ))
        ]));
  }
}
