import 'package:bookref/AuthenticationNavigator/unauthenticated_navigator.dart';
import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/add_recommendation.dart/add_recommendation.dart';
import 'package:bookref/blocs/book_details/book_details_bloc.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/library/library_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_bloc.dart';
import 'package:bookref/blocs/test/test_bloc.dart';
import 'package:bookref/blocs/wishlist/wishlist_bloc.dart';
import 'package:bookref/pages/addBook_page.dart';
import 'package:bookref/pages/addRecommendation_page.dart';
import 'package:bookref/pages/currents_page.dart';
import 'package:bookref/pages/details_page.dart';
import 'package:bookref/pages/library_page.dart';
import 'package:bookref/pages/register_page.dart';
import 'package:bookref/pages/test_page.dart';
import 'package:bookref/pages/wishlist_page.dart';
import 'package:bookref/repositories/repositories.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';
import 'pages/pages.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffE9E8E3), // navigation bar color
    statusBarColor: Color(0xffE9E8E3), //navigation bar icon
  ));

  WidgetsFlutterBinding.ensureInitialized();
  //await initHiveForFlutter();
  var dir = await getApplicationDocumentsDirectory();
  /*Hive
    ..init(dir.path)
    ..registerAdapter(DashboardBooksAdapter())
    ..registerAdapter(BookAdapter());*/

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

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return MaterialApp(
      title: 'Bookref',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return Scaffold(
              key: _scaffoldKey,
              drawer: NavDrawer(
                user: state.user,
              ),
              body: Container(
                decoration: BoxDecoration(color: Color(0xffE9E8E3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontSize: 40.0,
                                  fontFamily: 'Amaranth',
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: 'BOOK',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text: 'REF.',
                                      style: new TextStyle(
                                          color: Colors.orange[700],
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.add_circle_outline_rounded),
                              onPressed: () {
                                _navigatorKey.currentState
                                    .pushNamed("/addbook");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocListener<NotificationBloc, NotificationState>(
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
                          initialRoute: "/currents",
                          onGenerateRoute: (settings) {
                            return generateAuthRoute(settings, context);
                          },
                          key: _navigatorKey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNav(navCallback: (String namedRoute) {
                print("Navigating to $namedRoute");
                _navigatorKey.currentState
                    .pushNamedAndRemoveUntil(namedRoute, (r) => false);
              }),
            );
          }
          // Unauthenticated Pages
          return UnauthicatedNavigator();
        },
      ),
    );
  }
}

Route<dynamic> generateAuthRoute(RouteSettings settings, BuildContext context) {
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

Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());

    case '/register':
      return MaterialPageRoute(builder: (_) => RegisterPage());

    default:
      return MaterialPageRoute(builder: (_) => LoginPage());
  }
}
