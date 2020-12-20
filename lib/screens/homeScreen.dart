import 'package:bookref/pages/currentPage.dart';
import 'package:bookref/pages/dashboardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_currentIndex == 0) {
      content = DashboardPage();
    } else if (_currentIndex == 1) {
      content = CurrentPage();
    }

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 75.0,
          backgroundColor: Colors.black,
          titleSpacing: 25,
          title: const Text(
            "BOOKREF.",
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: content,
          ),
          new BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.white,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_library),
                  label: 'CURRENTS',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.restore),
                  label: 'WISHLIST',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'LIBARY',
                ),
              ]),
        ],
      ),
    );
  }
}
