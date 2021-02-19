import 'package:bookref/Bloc/addBook_bloc%20copy/addBook_bloc.dart';
import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/login_bloc/login_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:bookref/Pages/AddBook/addBookPage.dart';
import 'package:bookref/Pages/Login/loginPage.dart';
import 'package:bookref/Pages/Wishlist/wishlistPage.dart';
import 'package:bookref/Bloc/library_bloc/library_bloc.dart';
import 'package:bookref/Pages/Library/libraryPage.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Pages/Currents/currentsPage.dart';
import 'package:bookref/Pages/Dashboard/dashboardPage.dart';
import 'package:bookref/services/authenticationService.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/testNav.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "token");

  runApp(MaterialApp(
      onGenerateRoute: await Router.generateRoute, initialRoute: "/dashboard"));
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();
  final _navigatorKey = new GlobalKey<NavigatorState>();
  bool isBusy = true;
  bool isLoggedIn = false;
  bool isOnLogin = true;
  String _token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 Demo',
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
          body: Center(
              child: isBusy
                  ? CircularProgressIndicator()
                  : Scaffold(
                      body: Navigator(
                        initialRoute: isLoggedIn ? "/dashboard" : "/login",
                        onGenerateRoute: generateRoute,
                        key: _navigatorKey,
                      ),
                      bottomNavigationBar: isLoggedIn
                          ? BottomNav(navCallback: (String namedRoute) {
                              print("Navigating to $namedRoute");
                              _navigatorKey.currentState
                                  .pushReplacementNamed(namedRoute);
                            })
                          : null,
                    )),
        ));
  }

  Future<String> fetchToken() async {
    return await storage.read(key: "token");
  }

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() async {
    String token = await fetchToken();

    if (token != null) {
      setState(() {
        _token = token;
        isLoggedIn = true;
      });
    }

    setState(() {
      isBusy = false;
    });
  }

  changeIsOnLoginState(state) {
    setState(() {
      isOnLogin = state;
    });
  }

  // TODO: Hier fehlt noch die Validierung, ob Angemeldet!!!
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyDashboardBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: DashboardPage(),
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyLoginBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: LoginPage(),
                ));
      case '/currents':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyCurrentsBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: CurrentsPage(),
                ));
      case '/wishlist':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyWishlistBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: WishlistPage(),
                ));
      case '/library':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyLibraryBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: LibraryPage(),
                ));
      case '/addbook':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MyAddBookBloc(
                    bookrefRepository: BookrefRepository(
                      client: _client(_token),
                    ),
                  ),
                  child: AddBookPage(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
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

  /*return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: _link,
  );*/

  return GraphQLClient(
    cache: GraphQLCache(
      store: HiveStore(),
    ),
    link: _link,
  );
}

///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
/*
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
    cache: GraphQLCache(store: InMemoryStore()),
    link: _link,
  );

  /*return GraphQLClient(
    cache: GraphQLCache(
      store: HiveStore(),
    ),
    link: _link,
  );*/
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
      routes: {
        '/home': (context) => MyLoginApp(),
      },
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
                  return Scaffold(
                    body: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Navigator(
                            key: _navigatorKey,
                            onGenerateRoute: _onGenerateRoute,
                          ),
                        ),
                        /*new BottomNav(navCallback: (String namedRoute) {
                          print("Navigating to $namedRoute");
                          _navigatorKey.currentState
                              .pushReplacementNamed(namedRoute);
                        }),*/
                      ],
                    ),
                    bottomNavigationBar: ConvexAppBar(
                        style: TabStyle.fixedCircle,
                        items: [
                          TabItem(icon: Icons.dashboard, title: 'Home'),
                          TabItem(icon: Icons.local_library, title: 'Currents'),
                          TabItem(icon: Icons.add, title: 'Add'),
                          TabItem(icon: Icons.emoji_objects, title: 'Wishlist'),
                          TabItem(icon: Icons.library_books, title: 'Library'),
                        ],
                        initialActiveIndex: 0,
                        onTap: (int i) => {buildRoute(i)}),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  buildRoute(int i) {
    switch (i) {
      case 0:
        _navigatorKey.currentState.pushReplacementNamed("/");
        break;
      case 1:
        _navigatorKey.currentState.pushReplacementNamed("/currents");
        break;
      case 2:
        _navigatorKey.currentState.pushReplacementNamed("/addbook");
        break;
      case 3:
        _navigatorKey.currentState.pushReplacementNamed("/wishlist");
        break;
      case 4:
        _navigatorKey.currentState.pushReplacementNamed("/libary");
        break;
      default:
        _navigatorKey.currentState.pushReplacementNamed("/");
    }
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
      print("Actually Dashboard");
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
    } else if (settings.name == '/addbook') {
      isAuth = true;
      child = BlocProvider(
        create: (context) => MyAddBookBloc(
          bookrefRepository: BookrefRepository(
            client: _client(_token),
          ),
        ),
        child: AddBookPage(),
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
*/
