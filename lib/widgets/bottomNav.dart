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
    return new Material(
      color: Colors.black,
      elevation: 12.0,
      child: new Container(
        height: 56.0,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildButton('/', Icons.dashboard, "Dashboard"),
            _buildButton('/currents', Icons.local_library, "CURRENTS"),
            _buildButton('/stats', Icons.emoji_objects, "WISHLIST"),
            _buildButton('/messages', Icons.library_books, "LIBARY"),
            //_buildButton('/more', Icons.more_horiz, "More"),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String namedRoute, IconData data, String tooltip) {
    return new Flexible(
      flex: 1,
      child: new Tooltip(
        message: tooltip,
        child: new InkWell(
          onTap: () => onButtonTap(namedRoute),
          child: new Center(
            child: new Icon(
              data,
              size: 32.0,
              color: _currentRoute == namedRoute ? Colors.blue : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  onButtonTap(String namedRoute) {
    setState(() {
      _currentRoute = namedRoute;
    });
    widget.navCallback(_currentRoute);
  }
}
