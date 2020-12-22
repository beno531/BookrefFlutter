import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Pages/Dashboard/DashboardPage.dart';
import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

/*

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await custominitHiveForFlutter();

  await initHiveForFlutter();

  var box = await Hive.openBox('testBox');

  box.put('name', 'David');

  print('Name: ${box.get('name')}');

  final HttpLink httpLink = HttpLink(
    'https://bookref-api-dev.mi5u.de/graphql/',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: new MyApp(),
      )));
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
      child = new HomeScreen();
    } else if (settings.name == '/currents') {
      child = new CurrentsScreen();
    } else if (settings.name == '/wishlist') {
      child = new WishlistScreen();
    } else if (settings.name == '/libary') {
      child = new LibaryScreen();
    }
    if (child != null) {
      return new MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }
}


*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookref.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/dashboard",
      routes: {
        '/dashboard': (_) => BlocProvider(
              create: (context) => MyDashboardBloc(
                bookrefRepository: BookrefRepository(
                  client: _client(),
                ),
              ),
              child: DashboardPage(),
            ),
      },
    );
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

/*
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookref."),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('BLOC example'),
            onTap: () => Navigator.of(context).pushNamed('bloc'),
          ),
          Divider(),
          ListTile(
            title: Text('Extended BLOC example'),
            onTap: () => Navigator.of(context).pushNamed('extended-bloc'),
          ),
          Divider(),
        ],
      ),
    );
  }
  
}
*/
