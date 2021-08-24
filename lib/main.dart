import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bookref/Router/router.gr.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/pages/pages.dart';
import 'package:bookref/pages/private/currents_page.dart';
import 'package:bookref/pages/private/dashboardLayoutPage.dart';
import 'package:bookref/repositories/repositories.dart';
import 'package:bookref/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.white,
    statusBarColor: AppColors.background,
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
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class IniPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        log("message: ");
        log(state.toString());

        if (state is AuthenticationAuthenticated) {
          context.router.push(DashboardLayoutRoute());
        } else if (state is AuthenticationNotAuthenticated) {
          context.router.push(LoginRoute());
        }
      },
      builder: (context, state) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
    );
  }
}

/*
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



return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        log("message: ");
        log(state.toString());
        final appRouter = AppRouter();

        if (state is AuthenticationAuthenticated) {
          appRouter.replace(DashboardLayoutRoute());
        } else if (state is AuthenticationNotAuthenticated) {
          appRouter.push(LoginRoute());
        }
      },
      builder: (context, state) {
        return MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
*/