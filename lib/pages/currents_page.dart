import 'package:bookref/Models/book.dart';
import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/add_book/add_book_state.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/currents/currents_event.dart';
import 'package:bookref/blocs/currents/currents_state.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_state.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_bloc.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_state.dart';
import 'package:bookref/widgets/moveBookDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentsPage extends StatelessWidget {
  MoveBookDialog moveBookDialog;

  CurrentsPage() {
    moveBookDialog = MoveBookDialog();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentBloc>(context).add(LoadCurrentItems());
    return MultiBlocListener(
        listeners: [
          BlocListener<MoveBookBloc, MoveBookState>(listener: (context, state) {
            if (state is MoveBookFinished) {
              BlocProvider.of<CurrentBloc>(context).add(LoadCurrentItems());
            }
          }),
          BlocListener<RemoveBookBloc, RemoveBookState>(
              listener: (context, state) {
            if (state is RemoveBookFinished) {
              BlocProvider.of<CurrentBloc>(context).add(LoadCurrentItems());
            }
          }),
          BlocListener<AddBookBloc, AddBookState>(listener: (context, state) {
            if (state is AddBookSuccess) {
              print("Back im Game BOIIII");
            }
          })
        ],
        child:
            BlocBuilder<CurrentBloc, CurrentsState>(builder: (context, state) {
          final currentsBloc = BlocProvider.of<CurrentBloc>(context);

          if (state is CurrentItemsLoading) {
            return Container(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }

          if (state is CurrentItemsFinished) {
            final List<Book> currents = state.currents;

            return Container(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CURRENTS",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          /*Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      )*/
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
                                  Colors.orange[300],
                                  Colors.orange[800]
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
                                  Navigator.of(context).pushNamed(
                                      "/bookDetails",
                                      arguments: book);
                                },
                                onLongPress: () {
                                  moveBookDialog.show(book, context);
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
                              Navigator.of(context).pushNamed(
                                  "/addRecommendation",
                                  arguments: book.getBookId());
                            },
                          ),
                        ),
                      ]);
                    }),
                  ))
                ],
              ),
            );
          }

          if (state is CurrentItemsFailure) {
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
                      currentsBloc.add(LoadCurrentItems());
                    },
                  )
                ],
              )),
            );
          }

          return Text("Error");
        }));
  }
}
