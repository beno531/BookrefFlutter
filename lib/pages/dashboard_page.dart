import 'package:bookref/Models/book.dart';
import 'package:bookref/blocs/dashboard/dashboard_bloc.dart';
import 'package:bookref/blocs/dashboard/dashboard_event.dart';
import 'package:bookref/blocs/dashboard/dashboard_state.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_state.dart';
import 'package:bookref/widgets/buildHorizontalBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(LoadDashboardItems());
    return BlocListener<MoveBookBloc, MoveBookState>(
      listener: (context, state) {
        if (state is MoveBookFinished) {
          print("Lorem ipsum dolar sit amet");
          try {
            BlocProvider.of<DashboardBloc>(context)..add(LoadDashboardItems());
          } catch (e) {
            print(e.toString());
          }
        }
      },
      child:
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
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

        if (state is ReloadDashboardItems) {
          dashboardBloc.add(LoadDashboardItems());
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
          final List<Book> library = state.dashboardBooks.library;

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
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
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
                            BuildHorizontalBooks(library),
                          ])),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                            Container(
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
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
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
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

        return Text("Error");
      }),
    );
  }
}
