import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/login_bloc/login_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:bookref/Pages/Login/loginPage.dart';
import 'package:bookref/Pages/Wishlist/wishlistPage.dart';
import 'package:bookref/Bloc/library_bloc/library_bloc.dart';
import 'package:bookref/Pages/Library/libraryPage.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Pages/Currents/currentsPage.dart';
import 'package:bookref/Pages/Dashboard/dashboardPage.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "token");

  print(token);

  if (token != null) {
    runApp(MyMainApp());
  } else {
    runApp(MyLoginApp());
  }
}

GraphQLClient _client(token) {
  print(token);
  final HttpLink _httpLink = HttpLink(
    'https://bookref-api-dev.mi5u.de/graphql/',
    defaultHeaders: <String, String>{
      'Authorization': 'Bearer $token',
    },
  );

  final Link _link = _httpLink;

  return GraphQLClient(
    cache: GraphQLCache(
      store: HiveStore(),
    ),
    link: _link,
  );
}

getToken() async {
  final storage = new FlutterSecureStorage();
  return await storage.read(key: "token");
}

class MyLoginApp extends StatefulWidget {
  @override
  MyLoginAppState createState() => MyLoginAppState();
}

class MyLoginAppState extends State<MyLoginApp> {
  String _token;

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Token done');
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    var token = await getToken();
    setState(() {
      _token = token;
    });
  }

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
                  child: BlocProvider(
                create: (context) {
                  var bookrefRepository2 = BookrefRepository(
                    client: _client(_token),
                  );
                  return MyLoginBloc(
                    bookrefRepository: bookrefRepository2,
                  );
                },
                child: LoginPage(),
              )),
            ],
          ),
        ));
  }
}

class MyMainApp extends StatefulWidget {
  @override
  MyMainAppState createState() => MyMainAppState();
}

class MyMainAppState extends State<MyMainApp> {
  final _navigatorKey = new GlobalKey<NavigatorState>();
  bool isAuth = false;
  String _token;

  Future<String> _getThingsOnStartup() async {
    var token = await getToken();
    setState(() {
      _token = token;
    });
    return 'Data Received'; //TODO: Optimieren mit Token!!!
  }

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
              ),
              /*actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.login),
                  tooltip: 'Show Login Page',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyLoginApp()),
                    );
                  },
                ),
              ],*/
            ),
            body: FutureBuilder(
                future: _getThingsOnStartup(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Navigator(
                            key: _navigatorKey,
                            onGenerateRoute: _onGenerateRoute,
                          ),
                        ),
                        new BottomNav(navCallback: (String namedRoute) {
                          print("Navigating to $namedRoute");
                          _navigatorKey.currentState
                              .pushReplacementNamed(namedRoute);
                        }),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget child;
    if (settings.name == '/') {
      isAuth = false;
      child = BlocProvider(
        create: (context) => MyDashboardBloc(
          bookrefRepository: BookrefRepository(
            client: _client(_token),
          ),
        ),
        child: DashboardPage(),
      );
      print("Actually Login");
    } else if (settings.name == '/currents') {
      isAuth = true;
      child = BlocProvider(
        create: (context) => MyCurrentsBloc(
          bookrefRepository: BookrefRepository(
            client: _client(_token),
          ),
        ),
        child: CurrentsPage(),
      );
      print("Actually Currents");
    } else if (settings.name == '/wishlist') {
      isAuth = true;
      child = BlocProvider(
        create: (context) => MyWishlistBloc(
          bookrefRepository: BookrefRepository(
            client: _client(_token),
          ),
        ),
        child: WishlistPage(),
      );
      print("Actually Wishlist");
    } else if (settings.name == '/libary') {
      isAuth = true;
      child = BlocProvider(
        create: (context) => MyLibraryBloc(
          bookrefRepository: BookrefRepository(
            client: _client(_token),
          ),
        ),
        child: LibraryPage(),
      );
      print("Actually Library");
    }

    if (child != null) {
      return new MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }
}
