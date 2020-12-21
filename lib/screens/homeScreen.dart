import 'package:bookref/widgets/horizontalDashboardBookView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookref/graphql/query.dart' as queries;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        children: <Widget>[
          new HorizontalDashboardBookView(
              queries.getDoneDahsbaordBooks, "LIBARY", "/libary"),
          new HorizontalDashboardBookView(
              queries.getWishlistDahsbaordBooks, "WISHLIST", "/wishlist"),
          new HorizontalDashboardBookView(
              queries.getCurrentDahsbaordBooks, "CURRENT", "/currents")
        ],
      ),
    );
  }
}
