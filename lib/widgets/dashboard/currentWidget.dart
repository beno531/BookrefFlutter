import 'package:bookref/Models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/query.dart' as queries;

class Current extends StatefulWidget {
  @override
  _Current createState() => _Current();
}

class _Current extends State<Current> {
  @override
  Widget build(BuildContext context) {
    List<Books> listCurrent = List<Books>();

    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CURRENT",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "more",
                    style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  )
                ],
              )),
          Query(
            options: QueryOptions(
                documentNode: gql(queries.getCurrentDahsbaordBooks)),
            builder: (
              QueryResult result, {
              VoidCallback refetch,
              FetchMore fetchMore,
            }) {
              if (result.loading) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SpinKitThreeBounce(
                          color: Colors.white,
                          size: 25.0,
                        )
                      ]),
                );
              }

              if (!result.hasException) {
                for (var i = 0; i < result.data["books"].length; i++) {
                  listCurrent.add(
                    Books(result.data["books"][i]),
                  );
                }
              }

              return Container(
                height: MediaQuery.of(context).size.height * 0.22,
                child: ListView.builder(
                    padding: EdgeInsets.only(right: 25.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: listCurrent.length,
                    itemBuilder: (context, index) {
                      return Stack(children: <Widget>[
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.zero,
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              gradient: new LinearGradient(
                                colors: [
                                  Color.fromRGBO(247, 187, 151, 1.0),
                                  Color.fromRGBO(221, 94, 137, 1.0)
                                ],
                                begin: FractionalOffset.bottomLeft,
                                end: FractionalOffset.topRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      6, 6), // changes position of shadow
                                ),
                              ],
                            ),
                            margin: EdgeInsets.fromLTRB(25.0, 20.0, 0.0, 17.0),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.height *
                                double.infinity,
                            child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.zero,
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                textColor: Colors.black,
                                splashColor: Colors.black12,
                                onPressed: () {
                                  print("Flatbutton!!!");
                                },
                                onLongPress: () {
                                  print("Flatbutton!!!");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "${listCurrent[index].getBookTitle()}",
                                          maxLines: 4,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2,
                                              color: Colors.white),
                                          textAlign: TextAlign.left),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "${listCurrent[index].getAuthor()}",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.white),
                                          textAlign: TextAlign.left),
                                    ),
                                  ],
                                ))),
                        Positioned(
                          // will be positioned in the top right of the container
                          top: 22,
                          right: 2,
                          child: GestureDetector(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onTap: () {
                              print("Flatbutton!!!");
                            },
                          ),
                        ),
                      ]);
                    }),
              );
            },
          )
        ]));
  }
}
