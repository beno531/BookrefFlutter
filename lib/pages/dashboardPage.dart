import 'package:bookref/widgets/horizontalDashboardBookView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookref/graphql/query.dart' as queries;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        children: <Widget>[
          new HorizontalDashboardBookView(
              queries.getDoneDahsbaordBooks, "LIBARY"),
          new HorizontalDashboardBookView(
              queries.getWishlistDahsbaordBooks, "WISHLIST"),
          new HorizontalDashboardBookView(
              queries.getCurrentDahsbaordBooks, "CURRENT")
        ],
      ),
    );
  }
}
