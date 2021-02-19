import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/testNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookref/Pages/Dashboard/buildHorizontalBooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDashboardBooks extends StatelessWidget {
  final MyDashboardBloc bloc;

  const DisplayDashboardBooks({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyDashboardBloc, MyDashboardBooksState>(
      cubit: bloc,
      builder: (BuildContext context, MyDashboardBooksState state) {
        if (state is DashboardBooksLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading ...",
              ),
            ),
          );
        }

        if (state is DashboardBooksNotLoaded) {
          return Text("${state.errors}");
        }

        if (state is DashboardBooksLoaded) {
          final List<Books> currents = state.currents;
          final List<Books> wishlist = state.wishlist;
          final List<Books> libary = state.libary;

          return Container(
              decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
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
                                    InkResponse(
                                      onTap: () {
                                        //Navigator.pushNamed(context, route);
                                      },
                                      child: Text(
                                        "SEE ALL",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue),
                                      ),
                                    )
                                  ],
                                )),
                            BuildHorizontalBooks(libary),
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
                                    InkResponse(
                                      onTap: () {
                                        //Navigator.pushNamed(context, route);
                                      },
                                      child: Text(
                                        "SEE ALL",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue),
                                      ),
                                    )
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
                                    InkResponse(
                                      onTap: () {
                                        //Navigator.pushNamed(context, route);
                                      },
                                      child: Text(
                                        "SEE ALL",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue),
                                      ),
                                    )
                                  ],
                                )),
                            BuildHorizontalBooks(currents),
                          ]))
                    ],
                  ),
                ),
              ));
        }

        return Text(null);
      },
    );
  }
}

/*Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hallo",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            InkResponse(
                              onTap: () {
                                //Navigator.pushNamed(context, route);
                              },
                              child: Text(
                                "SEE ALL",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        )),
                    BuildHorizontalBooks(),
                  ]));*/
