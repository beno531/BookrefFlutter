import 'package:bookref/Models/books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookBookRecView extends StatefulWidget {
  Map<String, dynamic> arguments;
  BookBookRecView(this.arguments);

  @override
  _BookBookRecView createState() => _BookBookRecView(this.arguments);
}

class _BookBookRecView extends State<BookBookRecView> {
  Map<String, dynamic> arguments;

  _BookBookRecView(this.arguments);

  @override
  Widget build(BuildContext context) {
    final Books books = arguments['book'];

    print(arguments['book']);

    return Scaffold(
      appBar: AppBar(
        title: Text("BookBookRecView"),
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text(
                      'Erstellen',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () {},
                    color: Colors.orange,
                    child: Text(
                      'Erstellen',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
