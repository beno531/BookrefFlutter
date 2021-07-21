import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNav extends StatefulWidget {
  final String initialRoute;
  final ValueChanged<String> navCallback;

  BottomNav({
    Key key,
    this.initialRoute: '/dashbaord',
    @required this.navCallback,
  }) : super(key: key);

  @override
  _BottomNavState createState() => new _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String _currentRoute;
  int _initialActiveIndex = 0;

  @override
  void initState() {
    super.initState();
    //_currentRoute = widget.initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xffBFBFBF),
            spreadRadius: 180,
            blurRadius: 200,
            offset: Offset(0, 80),
          ),
        ],
      ),
      child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.dashboard),
            //   label: 'Dashboard',
            //   backgroundColor: Colors.grey.shade900,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: 'Currents',
              backgroundColor: Colors.grey.shade900,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add_circle_outline),
            //   label: 'Add',
            //   backgroundColor: Colors.grey.shade900,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_objects),
              label: 'Wishlist',
              backgroundColor: Colors.grey.shade900,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Library',
              backgroundColor: Colors.grey.shade900,
            ),
          ],
          currentIndex: _initialActiveIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xffF9F9F6),
          onTap: (int i) => {buildRoute(i)}),
    );
  }

  buildRoute(int i) {
    switch (i) {
      // case 0:
      //   onButtonTap("/dashboard", i);
      //   break;
      case 0:
        onButtonTap("/currents", i);
        break;
      // case 2:
      //   onButtonTap("/addbook", i);
      //   break;
      case 1:
        onButtonTap("/wishlist", i);
        break;
      case 2:
        onButtonTap("/library", i);
        break;
      default:
    }
  }

  onButtonTap(String namedRoute, int index) {
    setState(() {
      _currentRoute = namedRoute;
      _initialActiveIndex = index;
    });
    widget.navCallback(_currentRoute);
  }
}
