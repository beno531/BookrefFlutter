import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/currents/currents_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/currents/currents_event.dart';
import 'package:flutter_bloc_authentication/blocs/currents/currents_state.dart';
import 'package:flutter_bloc_authentication/blocs/library/library_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/library/library_event.dart';
import 'package:flutter_bloc_authentication/blocs/library/library_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LibraryBloc>(context).add(LoadLibraryItems());
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      final libraryBloc = BlocProvider.of<LibraryBloc>(context);

      if (state is LibraryItemsLoading) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is LibraryItemsFinished) {
        final List<Book> library = state.library;

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
                children: List.generate(library.length, (index) {
                  final book = library[index];
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
                            colors: [Colors.orange[300], Colors.orange[800]],
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
                              /*Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailView({"book": book})));*/
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
                                          fontSize: 10.0, color: Colors.white),
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
        );
      }

      if (state is LibraryItemsFailure) {
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
                  libraryBloc.add(LoadLibraryItems());
                },
              )
            ],
          )),
        );
      }
    });
  }
}
