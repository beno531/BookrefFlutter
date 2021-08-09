import 'package:bookref/AccessNavigator/route_manager.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:bookref/models/user.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateNavigator extends StatefulWidget {
  @override
  _PrivateNavigatorState createState() => _PrivateNavigatorState();
}

class _PrivateNavigatorState extends State<PrivateNavigator> {
  final _navigatorKey = new GlobalKey<NavigatorState>();
  final _routewManager = new RouteManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
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
        initialRoute: "/dashboard/currents",
        onGenerateRoute: (settings) {
          return _routewManager.generatePrivateRoute(settings, context);
        },
        key: _navigatorKey,
      ),
    );
  }
}
