import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final String initialRoute;
  final ValueChanged<String> navCallback;

  BottomNav({
    Key key,
    this.initialRoute: '/',
    @required this.navCallback,
  }) : super(key: key);

  @override
  _BottomNavState createState() => new _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String _currentRoute;

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.dashboard, title: 'Home'),
          TabItem(icon: Icons.local_library, title: 'Currents'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.emoji_objects, title: 'Wishlist'),
          TabItem(icon: Icons.library_books, title: '´Library'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => {buildRoute(i)});
  }

  buildRoute(int i) {
    switch (i) {
      case 0:
        onButtonTap("/dashboard");
        break;
      case 1:
        onButtonTap("/currents");
        break;
      case 2:
        onButtonTap("/addbook");
        break;
      case 3:
        onButtonTap("/wishlist");
        break;
      case 4:
        onButtonTap("/library");
        break;
      default:
    }
  }

  onButtonTap(String namedRoute) {
    if (_currentRoute != namedRoute) {
      setState(() {
        _currentRoute = namedRoute;
      });
      widget.navCallback(_currentRoute);
    }
  }
}
