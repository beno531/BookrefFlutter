import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_event.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';
import 'package:flutter_bloc_authentication/widgets/buildHorizontalBooks.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(LoadDashboardItems());
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      final dashboardBloc = BlocProvider.of<DashboardBloc>(context);

      if (state is DashboardItemsLoading) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is DashboardItemsFinished) {
        final List<Book> currents = state.dashboardBooks.currents;
        final List<Book> wishlist = state.dashboardBooks.wishlist;
        final List<Book> libary = state.dashboardBooks.library;

        return Container(
            decoration: BoxDecoration(color: Colors.grey[800]),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "LIBRARY",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  // InkResponse(
                                  //   onTap: () {
                                  //     Navigator.pushReplacementNamed(
                                  //         context, "/library");
                                  //   },
                                  //   child: Text(
                                  //     "SEE ALL",
                                  //     style: TextStyle(
                                  //         fontSize: 14.0,
                                  //         fontWeight: FontWeight.w700,
                                  //         color: Colors.grey[300]),
                                  //   ),
                                  // )
                                ],
                              )),
                          BuildHorizontalBooks(libary),
                        ])),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "WISHLIST",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  // InkResponse(
                                  //   onTap: () {
                                  //     Navigator.pushReplacementNamed(
                                  //         context, "/wishlist");
                                  //   },
                                  //   child: Text(
                                  //     "SEE ALL",
                                  //     style: TextStyle(
                                  //         fontSize: 14.0,
                                  //         fontWeight: FontWeight.w700,
                                  //         color: Colors.grey[300]),
                                  //   ),
                                  // )
                                ],
                              )),
                          BuildHorizontalBooks(wishlist),
                        ])),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CURRENTS",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  // InkResponse(
                                  //   onTap: () {
                                  //     Navigator.pushReplacementNamed(
                                  //         context, "/currents");
                                  //   },
                                  //   child: Text(
                                  //     "SEE ALL",
                                  //     style: TextStyle(
                                  //         fontSize: 14.0,
                                  //         fontWeight: FontWeight.w700,
                                  //         color: Colors.grey[300]),
                                  //   ),
                                  // )
                                ],
                              )),
                          BuildHorizontalBooks(currents),
                        ]))
                  ],
                ),
              ),
            ));
      }

      if (state is DashboardItemsFailure) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(state.message),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Retry'),
                onPressed: () {
                  dashboardBloc.add(LoadDashboardItems());
                },
              )
            ],
          )),
        );
      }
    });
  }
}
