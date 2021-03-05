import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/add_recommendation.dart/add_recommendation.dart';
import 'package:bookref/blocs/book_details/book_details_bloc.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/dashboard/dashboard_bloc.dart';
import 'package:bookref/blocs/library/library_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:bookref/blocs/wishlist/wishlist_bloc.dart';
import 'package:bookref/pages/addBook_page.dart';
import 'package:bookref/pages/addRecommendation_page.dart';
import 'package:bookref/pages/currents_page.dart';
import 'package:bookref/pages/dashboard_page.dart';
import 'package:bookref/pages/details_page.dart';
import 'package:bookref/pages/library_page.dart';
import 'package:bookref/pages/wishlist_page.dart';
import 'package:bookref/repositories/repositories.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/navDrawer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';
import 'pages/pages.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[900], // navigation bar color
    statusBarColor: Colors.grey[900], // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.greenAccent, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  await initHiveForFlutter();

  runApp(
      // Injects the Authentication service
      MultiRepositoryProvider(
          providers: [
        RepositoryProvider<AuthenticationService>(create: (context) {
          return AuthenticationService();
        }),
        RepositoryProvider<BookrefRepository>(create: (context) {
          return BookrefRepository();
        }),
      ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(create: (context) {
                final authService =
                    RepositoryProvider.of<AuthenticationService>(context);
                //final bookrefService = RepositoryProvider.of<BookrefService>(context);
                return AuthenticationBloc(authService)..add(AppLoaded());
              }),
              BlocProvider(create: (context) => NotificationBloc())
            ],
            child: MyApp(),
          )));
}

class MyApp extends StatelessWidget {
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookref',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return Scaffold(
              drawer: NavDrawer(
                user: state.user,
              ),
              appBar: AppBar(
                  toolbarHeight: 75.0,
                  backgroundColor: Colors.grey[900],
                  titleSpacing: 25,
                  title: const Text(
                    "BOOKREF.",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              body: BlocListener<NotificationBloc, NotificationState>(
                listener: (context, state) {
                  if (state is NotificationPushed) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: state.status,
                      content: Container(
                        height: 50.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                state.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              state.message,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Navigator(
                  initialRoute: "/dashboard",
                  onGenerateRoute: (settings) {
                    return generateRoute(settings);
                  },
                  key: _navigatorKey,
                ),
              ),
              bottomNavigationBar: BottomNav(navCallback: (String namedRoute) {
                print("Navigating to $namedRoute");
                _navigatorKey.currentState
                    .pushNamedAndRemoveUntil(namedRoute, (r) => false);
              }),
            );
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    Flushbar(
      title: "Success!",
      message: message,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/dashboard':
      return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => DashboardBloc(
                            dataService: DataService(),
                          )),
                  BlocProvider(
                      create: (context) => MoveBookBloc(
                            dataService: DataService(),
                          ))
                ],
                child: DashboardPage(),
              ));
    case '/currents':
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
                          ))
                ],
                child: CurrentsPage(),
              ));

    case '/wishlist':
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
                          ))
                ],
                child: WishlistPage(),
              ));
    case '/library':
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
                          ))
                ],
                child: LibraryPage(),
              ));
    case '/addbook':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => AddBookBloc(dataService: DataService()),
                child: AddBookPage(),
              ));
    case '/addRecommendation':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => AddRecommendationBloc(
                    dataService: DataService(), bookId: settings.arguments),
                child: AddRecommendationPage(),
              ));
    case '/bookDetails':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) =>
                    BookDetailsBloc(dataService: DataService()),
                child: BookDetailsPage(bookRef: settings.arguments),
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
