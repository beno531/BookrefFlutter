import 'package:bookref/pages/pages.dart';
import 'package:bookref/pages/register_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  Route<dynamic> generateUnauthRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
