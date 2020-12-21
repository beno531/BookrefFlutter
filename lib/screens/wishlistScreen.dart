import 'package:bookref/widgets/standaloneGridBookView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookref/graphql/query.dart' as queries;

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreen createState() => _WishlistScreen();
}

class _WishlistScreen extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        children: <Widget>[
          new StanaloneGridBookView(
              queries.getWishlistDahsbaordBooks, "WISHLIST VIEW")
        ],
      ),
    );
  }
}
