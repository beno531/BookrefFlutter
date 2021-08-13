import 'package:bookref/pages/private/addRecommendation_page.dart';
import 'package:bookref/pages/private/addBook_page.dart';
import 'package:bookref/pages/private/currents_page.dart';
import 'package:bookref/pages/private/details_page.dart';
import 'package:bookref/pages/pages.dart';
import 'package:bookref/AccessNavigator/dashbaord_navigator_page.dart';
import 'package:bookref/pages/public/register_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  Route<dynamic> generatePublicRoute(
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

  Route<dynamic> generatePrivateRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardNavigatorPage());

      case '/bookDetails':
        return MaterialPageRoute(
            builder: (_) => BookDetailsPage(book: settings.arguments));

      case '/addBook':
        return MaterialPageRoute(builder: (_) => AddBookPage());

      case '/addRecommendation':
        return MaterialPageRoute(
            builder: (_) => AddRecommendationPage(settings.arguments));

      default:
        return MaterialPageRoute(builder: (_) => DashboardNavigatorPage());
    }
  }

  Route<dynamic> generateDashboardRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/currents':
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CurrentsPage(),
            transitionDuration: Duration(seconds: 0));

      case '/wishlist':
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => Text("Wishlist"),
            transitionDuration: Duration(seconds: 0));

      default:
        return MaterialPageRoute(builder: (_) => (CurrentsPage()));
    }
  }
}
