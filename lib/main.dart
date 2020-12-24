import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:bookref/Pages/Wishlist/wishlistPage.dart';
import 'package:bookref/Bloc/libary_bloc/libary_bloc.dart';
import 'package:bookref/Pages/Libary/libaryPage.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Pages/Currents/currentsPage.dart';
import 'package:bookref/Pages/Dashboard/dashboardPage.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bookref.',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
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
                child: new Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: _onGenerateRoute,
                ),
              ),
              new BottomNav(navCallback: (String namedRoute) {
                print("Navigating to $namedRoute");
                _navigatorKey.currentState.pushReplacementNamed(namedRoute);
              }),
            ],
          ),
        ));
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget child;
    if (settings.name == '/') {
      child = BlocProvider(
        create: (context) => MyDashboardBloc(
          bookrefRepository: BookrefRepository(
            client: _client(),
          ),
        ),
        child: DashboardPage(),
      );
    } else if (settings.name == '/currents') {
      child = BlocProvider(
        create: (context) => MyCurrentsBloc(
          bookrefRepository: BookrefRepository(
            client: _client(),
          ),
        ),
        child: CurrentsPage(),
      );
    } else if (settings.name == '/wishlist') {
      child = BlocProvider(
        create: (context) => MyWishlistBloc(
          bookrefRepository: BookrefRepository(
            client: _client(),
          ),
        ),
        child: WishlistPage(),
      );
    } else if (settings.name == '/libary') {
      child = BlocProvider(
        create: (context) => MyLibaryBloc(
          bookrefRepository: BookrefRepository(
            client: _client(),
          ),
        ),
        child: LibaryPage(),
      );
    }

    if (child != null) {
      return new MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }

  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      'https://bookref-api-dev.mi5u.de/graphql/',
    );

    final Link _link = _httpLink;

    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _link,
    );
  }
}
