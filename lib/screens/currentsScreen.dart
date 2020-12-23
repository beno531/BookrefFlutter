import 'package:bookref/widgets/standaloneGridBookView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookref/graphql/query.dart' as queries;

class CurrentsScreen extends StatefulWidget {
  @override
  _CurrentsScreen createState() => _CurrentsScreen();
}

class _CurrentsScreen extends State<CurrentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        children: <Widget>[
          //new StanaloneGridBookView(queries.getCurrentDahsbaordBooks, "CURRENTS VIEW")
        ],
      ),
    );
  }
}
