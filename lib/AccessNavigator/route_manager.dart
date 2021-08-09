import 'dart:developer';

import 'package:bookref/pages/private/addBook_page.dart';
import 'package:bookref/pages/private/currents_page.dart';
import 'package:bookref/pages/private/details_page.dart';
import 'package:bookref/pages/pages.dart';
import 'package:bookref/pages/private/dashbaord_navigator_page.dart';
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
      case '/dashboard/currents':
        return MaterialPageRoute(
            builder: (_) => DashboardNavigatorPage(child: CurrentsPage()));

      case '/bookDetails':
        return MaterialPageRoute(
            builder: (_) => BookDetailsPage(book: settings.arguments));

      case '/addBook':
        return MaterialPageRoute(builder: (_) => AddBookPage());

      default:
        return MaterialPageRoute(
            builder: (_) => DashboardNavigatorPage(child: CurrentsPage()));
    }
  }

// Muss weg
  Route<dynamic> generateDashboardRoute(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/currents':
        return MaterialPageRoute(builder: (_) => CurrentsPage());
/*
      case '/wishlist':
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => WishlistBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => MoveBookBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => RemoveBookBloc(
                              dataService: DataService(),
                            ))
                  ],
                  child: WishlistPage(),
                ));
      case '/library':
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => LibraryBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => MoveBookBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => RemoveBookBloc(
                              dataService: DataService(),
                            ))
                  ],
                  child: LibraryPage(),
                ));
      case '/test':
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TestBloc(dataService: DataService()),
                  child: TestPage(),
                ));*/
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
