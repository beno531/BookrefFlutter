import 'package:auto_route/auto_route.dart';
import 'package:bookref/Router/router.gr.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_state.dart';
import 'package:bookref/models/user.dart';
import 'package:bookref/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardLayoutPage extends StatefulWidget {
  DashboardLayoutPage({Key key}) : super(key: key);

  @override
  _DashboardLayoutPageState createState() => _DashboardLayoutPageState();
}

class _DashboardLayoutPageState extends State<DashboardLayoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        drawer: NavDrawer(
          user: User(name: "%Placeholder%"),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        builder: (context, child, animation) {
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
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context.router.push(
                                AddBookRoute(),
                              );
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
                      child: child,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        routes: const [
          CurrentsRoute(),
          WishlistRoute(),
          LibraryRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.orange,
            items: [
              BottomNavigationBarItem(
                  label: 'Currents', icon: Icon(Icons.local_library)),
              BottomNavigationBarItem(
                  label: 'Wishlist', icon: Icon(Icons.emoji_objects)),
              BottomNavigationBarItem(
                  label: 'Library', icon: Icon(Icons.library_books)),
            ],
          );
        });
  }
}
