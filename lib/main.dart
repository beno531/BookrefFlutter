import 'package:bookref/AccessNavigator/private_navigator.dart';
import 'package:bookref/AccessNavigator/public_navigator.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookref',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // Private Pages
            return PrivateNavigator();
          }
          // Public Pages
          return PublicNavigator();
        },
      ),
    );
  }
}
