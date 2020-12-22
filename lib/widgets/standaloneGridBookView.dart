/*import 'package:bookref/Models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StanaloneGridBookView extends StatelessWidget {
  final String query;
  final String categorieName;

  StanaloneGridBookView(this.query, this.categorieName);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$categorieName",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  )
                ],
              )),
          Expanded(
            child: Query(
              options: QueryOptions(documentNode: gql(query)),
              builder: (
                QueryResult result, {
                VoidCallback refetch,
                FetchMore fetchMore,
              }) {
                if (result.loading) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.17,
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

                var listBooks = List<Books>();

                if (!result.hasException) {
                  for (var i = 0; i < result.data["books"].length; i++) {
                    listBooks.add(
                      Books(result.data["books"][i]),
                    );
                  }
                }

                final List<Books> books = listBooks;

                return GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(books.length, (index) {
                    final book = books[index];
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
                                offset:
                                    Offset(6, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                                    child: Text("${book.getBookTitle()}",
                                        maxLines: 5,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2,
                                            color: Colors.white),
                                        textAlign: TextAlign.left),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${book.getAuthor()}",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ))),
                      Positioned(
                        top: 12,
                        right: 12,
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
            ),
          )
        ]));
  }
}

/*
class StanaloneGridBookView extends StatelessWidget {
  final String query;
  final String categorieName;

  StanaloneGridBookView(this.query, this.categorieName);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$categorieName",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  )
                ],
              )),
          Query(
            options: QueryOptions(documentNode: gql(query)),
            builder: (
              QueryResult result, {
              VoidCallback refetch,
              FetchMore fetchMore,
            }) {
              if (result.loading) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.17,
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

              var listBooks = List<Books>();

              if (!result.hasException) {
                for (var i = 0; i < result.data["books"].length; i++) {
                  listBooks.add(
                    Books(result.data["books"][i]),
                  );
                }
              }

              final List<Books> books = listBooks;

              return Container(
                height: MediaQuery.of(context).size.height * 40,
                child: ListView.builder(
                    padding: EdgeInsets.only(right: 25.0),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
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
                            margin: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 10.0),
                            width: MediaQuery.of(context).size.width * 20.0,
                            height: MediaQuery.of(context).size.height * 0.12,
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
                                      child: Text("${book.getBookTitle()}",
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
                                      child: Text("${book.getAuthor()}",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.white),
                                          textAlign: TextAlign.left),
                                    ),
                                  ],
                                ))),
                        Positioned(
                          top: 10,
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

*/
*/
