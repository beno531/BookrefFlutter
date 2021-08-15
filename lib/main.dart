import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bookref/Router/router.gr.dart';
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

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        log(state.toString());
        return MaterialApp.router(
          routerDelegate: AutoRouterDelegate.declarative(
            _appRouter,
            routes: (_) => [
              state is AuthenticationAuthenticated
                  ? DashboardLayoutRoute()
                  : LoginRoute()
            ],
          ),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
