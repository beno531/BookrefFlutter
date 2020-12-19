import 'package:bookref/Models/books.dart';
import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/widgets/dashboard/currentWidget.dart';
import 'package:bookref/widgets/dashboard/readWidget.dart';
import 'package:bookref/widgets/dashboard/wishlistWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<Books> listCurrent = List<Books>();
  List<Books> listWishlist = List<Books>();

  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8];

/*
    //Nur zum Debugen
    void _showDialog(title, content) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

*/

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 75.0,
          backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
          titleSpacing: 25,
          title: const Text(
            "BOOKREF.",
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
        child: Column(
          children: <Widget>[Read(), Wishlist(), Current()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'MAIN',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: 'CURRENT',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'PROFIL',
            ),
          ]),
    );
  }
}
