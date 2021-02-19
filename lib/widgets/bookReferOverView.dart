import 'package:bookref/Models/books.dart';
import 'package:bookref/widgets/bookBookRecView.dart';
import 'package:bookref/widgets/bookPersonRecView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookReferOverView extends StatefulWidget {
  Map<String, dynamic> arguments;
  BookReferOverView(this.arguments);

  @override
  _BookReferOverView createState() => _BookReferOverView(this.arguments);
}

class _BookReferOverView extends State<BookReferOverView> {
  Map<String, dynamic> arguments;

  _BookReferOverView(this.arguments);

  @override
  Widget build(BuildContext context) {
    final Books books = arguments['book'];

    print(arguments['book']);

    return Scaffold(
      appBar: AppBar(
        title: Text("ADD REFERENCE"),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BookBookRecView({"book": books})));
                    },
                    color: Colors.blue,
                    child: Text(
                      'Book Rec',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BookPersonRecView({"book": books})));
                    },
                    color: Colors.orange,
                    child: Text(
                      'Person Rec',
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
