import 'package:bookref/Models/books.dart';
import 'package:bookref/widgets/bookDetailView.dart';
import 'package:bookref/widgets/testNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayWishlistBooks extends StatelessWidget {
  final MyWishlistBloc bloc;

  const DisplayWishlistBooks({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyWishlistBloc, MyWishlistState>(
      cubit: bloc,
      builder: (BuildContext context, MyWishlistState state) {
        if (state is WishlistBooksLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading ...",
              ),
            ),
          );
        }

        if (state is WishlistBooksNotLoaded) {
          return Text("${state.errors}");
        }

        if (state is WishlistBooksLoaded) {
          final List<Books> currents = state.wishlist;
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "WISHLIST VIEW",
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
                      child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    children: List.generate(currents.length, (index) {
                      final book = currents[index];
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BookDetailView({"book": book})));
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
                                      //child: Text("${book.getAuthor()}",
                                      child: Text("Placeholder",
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
                  ))
                ],
              ),
            ),
          );
        }

        return Text(null);
      },
    );
  }
}
