import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookref/Models/bookref_models.dart';
import 'package:bookref/services/bookref_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<Data> books = [];

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  getBooks() async {
    BookrefApi instance = BookrefApi();
    List<Data> books = await instance.fetchBooks();
    setState(() {
      this.books = books;
    });
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
                        itemCount: books.length,
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
                                          child: Text(books[index].title,
                                              maxLines: 4,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2,
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
                        itemCount: numbers.length,
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
                                              "Dieses Buch ist Bares Geld Wert",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Markus Elsässer",
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
                        itemCount: numbers.length,
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
                                            "Dieses Buch ist Bares Geld Wert",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700,
                                                height: 1.2,
                                                color: Colors.white),
                                            textAlign: TextAlign.left),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Markus Elsässer",
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
