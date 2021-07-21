import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/add_recommendation.dart/add_recommendation.dart';
import 'package:bookref/blocs/book_details/book_details_bloc.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/library/library_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_bloc.dart';
import 'package:bookref/blocs/test/test_bloc.dart';
import 'package:bookref/blocs/wishlist/wishlist_bloc.dart';
import 'package:bookref/pages/addBook_page.dart';
import 'package:bookref/pages/addRecommendation_page.dart';
import 'package:bookref/pages/currents_page.dart';
import 'package:bookref/pages/details_page.dart';
import 'package:bookref/pages/library_page.dart';
import 'package:bookref/pages/pages.dart';
import 'package:bookref/pages/public/register_page.dart';
import 'package:bookref/pages/test_page.dart';
import 'package:bookref/pages/wishlist_page.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      case '/currents':
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => CurrentBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => MoveBookBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => RemoveBookBloc(
                              dataService: DataService(),
                            )),
                    BlocProvider(
                        create: (context) => AddBookBloc(
                              dataService: DataService(),
                            ))
                  ],
                  child: CurrentsPage(),
                ));

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
      case '/addbook':
        BlocProvider.of<NavigationBloc>(context).add(ChangeNavigationOnSub());
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddBookBloc(dataService: DataService()),
                  child: AddBookPage(),
                ));
      case '/addRecommendation':
        BlocProvider.of<NavigationBloc>(context).add(ChangeNavigationOnSub());
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddRecommendationBloc(
                      dataService: DataService(), bookId: settings.arguments),
                  child: AddRecommendationPage(),
                ));
      case '/bookDetails':
        BlocProvider.of<NavigationBloc>(context).add(ChangeNavigationOnSub());
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      BookDetailsBloc(dataService: DataService()),
                  child: BookDetailsPage(bookRef: settings.arguments),
                ));
      case '/test':
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TestBloc(dataService: DataService()),
                  child: TestPage(),
                ));
      default:
        BlocProvider.of<NavigationBloc>(context)
            .add(ChangeNavigationOnMain(route: settings.name));
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
