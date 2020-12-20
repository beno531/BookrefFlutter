import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookref/graphql/query.dart' as queries;

class CurrentPage extends StatefulWidget {
  @override
  _CurrentPage createState() => _CurrentPage();
}

class _CurrentPage extends State<CurrentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        //children: <Widget>[new CurrentStandalone()],TestBookView
        children: <Widget>[new Text("data")],
      ),
    );
  }
}
