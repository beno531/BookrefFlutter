import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/screens/currentsScreen.dart';
import 'package:bookref/screens/homeScreen.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GraphQLProvider(
    client: graphQLConfiguration.client,
    child: CacheProvider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
      },
    )),
  ));
}
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GraphQLProvider(
      client: graphQLConfiguration.client,
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
    } else if (settings.name == '/stats') {
      //child = new OtherScreen('Statistics');
    } else if (settings.name == '/messages') {
      //child = new OtherScreen('Messages');
    } else if (settings.name == '/more') {
      //child = new OtherScreen('More');
    }
    if (child != null) {
      return new MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }
}
