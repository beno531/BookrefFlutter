import 'package:bookref/AccessNavigator/route_manager.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicNavigator extends StatefulWidget {
  @override
  _PublicNavigatorState createState() => _PublicNavigatorState();
}

class _PublicNavigatorState extends State<PublicNavigator> {
  final _navigatorKey = new GlobalKey<NavigatorState>();
  final _routewManager = new RouteManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationPushed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                            color: Colors.white, fontWeight: FontWeight.bold),
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
          initialRoute: "/login",
          onGenerateRoute: (settings) {
            return _routewManager.generatePublicRoute(settings, context);
          },
          key: _navigatorKey,
        ),
      ),
    );
  }
}
