import 'package:bookref/AccessNavigator/route_manager.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:bookref/models/user.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardNavigatorPage extends StatefulWidget {
  final Widget child;

  DashboardNavigatorPage({Key key, this.child}) : super(key: key);

  @override
  _DashboardNavigatorPageState createState() => _DashboardNavigatorPageState();
}

class _DashboardNavigatorPageState extends State<DashboardNavigatorPage> {
  final _routewManager = new RouteManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(
        user: User(name: "%Placeholder%"),
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
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          new TextSpan(
                              text: 'REF.',
                              style: new TextStyle(
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, "/addBook", arguments: {});
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
                  child: widget.child),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(navCallback: (String namedRoute) {
        print("Navigating to $namedRoute");
        //_navigatorKey.currentState.pushNamedAndRemoveUntil(namedRoute, (r) => false);
      }),
    );
  }
}
