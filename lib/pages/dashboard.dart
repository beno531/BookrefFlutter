import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/Models/bookref_models.dart';
import 'package:bookref/Models/person.dart';
import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/graphql/queryMutation.dart';
import 'package:bookref/services/bookref_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/query.dart' as queries;

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<Books> listCurrent = List<Books>();
  List<Books> listWishlist = List<Books>();
  List<Books> listRead = List<Books>();

  @override
  void initState() {
    super.initState();
    fillList();
  }

  void fillList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult current_result = await _client.query(
      QueryOptions(
        document: queryMutation.getCurrentDahsbaordBooks(),
        //TODO: documentNode: gql("queryMutation.getCurrentDahsbaordBooks"),
      ),
    );

    QueryResult wishlist_result = await _client.query(
      QueryOptions(
        document: queryMutation.getWishlistDahsbaordBooks(),
        //TODO: documentNode: gql("queryMutation.getCurrentDahsbaordBooks"),
      ),
    );

    QueryResult read_result = await _client.query(
      QueryOptions(
        document: queryMutation.getReadDahsbaordBooks(),
        //TODO: documentNode: gql("queryMutation.getCurrentDahsbaordBooks"),
      ),
    );

    if (!current_result.hasException) {
      for (var i = 0; i < current_result.data["books"].length; i++) {
        setState(() {
          listCurrent.add(
            Books(current_result.data["books"][i]),
          );
        });
      }
    }

    if (!wishlist_result.hasException) {
      for (var i = 0; i < wishlist_result.data["books"].length; i++) {
        setState(() {
          listWishlist.add(
            Books(wishlist_result.data["books"][i]),
          );
        });
      }
    }

    if (!read_result.hasException) {
      for (var i = 0; i < read_result.data["books"].length; i++) {
        setState(() {
          listRead.add(
            Books(read_result.data["books"][i]),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8];

    //Nur zum Debugen
    void _showDialog(title, content) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 75.0,
          backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
          titleSpacing: 25,
          title: const Text(
            "BOOKREF.",
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "READ",
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: ListView.builder(
                        padding: EdgeInsets.only(right: 25.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: listRead.length,
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
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 20.0, 0.0, 17.0),
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
                                      _showDialog("Details",
                                          "Hier stehen dann die Details!");
                                    },
                                    onLongPress: () {
                                      _showDialog(
                                          "Delete", "Weg mit dem Mist!!!!");
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "${listRead[index].getBookTitle()}",
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
                                              "${listRead[index].getAuthor()}",
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
                                  print("Iconbutton!!!");
                                  _showDialog("Refenrenz hinzufügen",
                                      "Guckst du, hier kannst du Referenzen hinzufügen!!!");
                                },
                              ),
                            ),
                          ]);
                        }),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "WISHLIST",
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: ListView.builder(
                        padding: EdgeInsets.only(right: 25.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: listWishlist.length,
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
                                      Color.fromRGBO(81, 99, 149, 1.0),
                                      Color.fromRGBO(97, 67, 133, 1.0)
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
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 20.0, 0.0, 17.0),
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
                                      _showDialog("Details",
                                          "Hier stehen dann die Details!");
                                    },
                                    onLongPress: () {
                                      _showDialog(
                                          "Delete", "Weg mit dem Mist!!!!");
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "${listWishlist[index].getBookTitle()}",
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
                                              "${listWishlist[index].getAuthor()}",
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
                                  _showDialog("Refenrenz hinzufügen",
                                      "Guckst du, hier kannst du Referenzen hinzufügen!!!");
                                },
                              ),
                            ),
                          ]);
                        }),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                children: <Widget>[
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
                  Container(
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
                                      Color.fromRGBO(0, 205, 172, 1.0),
                                      Color.fromRGBO(2, 170, 176, 1.0)
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
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 20.0, 0.0, 17.0),
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
                                    //Navigator.of(context).pop();
                                    _showDialog("Details",
                                        "Hier stehen dann die Details!");
                                  },
                                  onLongPress: () {
                                    print("LongPressFlatbutton!!");
                                    _showDialog(
                                        "Delete", "Weg mit dem Mist!!!!");
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
                                  ),
                                )),
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
                                  print("Iconbutton!!!");
                                  _showDialog("Refenrenz hinzufügen",
                                      "Guckst du, hier kannst du Referenzen hinzufügen!!!");
                                },
                              ),
                            ),
                          ]);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'MAIN',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: 'CURRENT',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'PROFIL',
            ),
          ]),
    );
  }
}
