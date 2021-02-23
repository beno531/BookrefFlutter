import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestBottomNav extends StatefulWidget {
  @override
  _TestBottomNavState createState() => new _TestBottomNavState();
}

class _TestBottomNavState extends State<TestBottomNav> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.dashboard, title: 'Home'),
          TabItem(icon: Icons.local_library, title: 'Currents'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.emoji_objects, title: 'Wishlist'),
          TabItem(icon: Icons.library_books, title: 'Library'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => {buildRoute(i)});
  }

  buildRoute(int i) {
    switch (i) {
      case 0:
        Navigator.pushNamed(context, "/dashboard");
        break;
      case 1:
        Navigator.pushNamed(context, "/currents");
        break;
      case 2:
        Navigator.pushNamed(context, "/dashboard");
        break;
      case 3:
        Navigator.pushNamed(context, "/wishlist");
        break;
      case 4:
        Navigator.pushNamed(context, "/library");
        break;
      default:
    }
  }
}
