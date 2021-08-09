import 'package:bookref/models/book.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/currents/currents_event.dart';
import 'package:bookref/blocs/currents/currents_state.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
                top: size.height * 0.05,
                left: 30,
                right: 30,
                child: Center(
                    child: Material(
                  elevation: 10.0,
                  shadowColor: Color(0xffC1C1C1),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Search'),
                  ),
                ))),
            Positioned(
              top: size.height * 0.15,
              left: 30,
              right: 0,
              child: Text(
                "CURRENTS",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff505050)),
                textAlign: TextAlign.left,
              ),
            ),
            Positioned(
              top: size.height * 0.20,
              bottom: 0,
              left: 30,
              right: 30,
              child: Container(
                child: _CurrentBooksDisplay(),
              ),
            )
          ],
        ));
  }
}

class _CurrentBooksDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CurrentBloc(
              dataService: DataService(),
            ),
        child: _CurrentBooks());
  }
}

class _CurrentBooks extends StatefulWidget {
  @override
  __CurrentBooksState createState() => __CurrentBooksState();
}

class __CurrentBooksState extends State<_CurrentBooks> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentBloc>(context).add(LoadCurrentItems());
    final _currentsBloc = BlocProvider.of<CurrentBloc>(context);

    return BlocBuilder<CurrentBloc, CurrentsState>(builder: (context, state) {
      //final currentsBloc = BlocProvider.of<CurrentBloc>(context);

      if (state is CurrentItemsLoading) {
        return Container(
          decoration: BoxDecoration(color: Color(0xffE9E8E3)),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is CurrentItemsFinished) {
        final List<Book> currents = state.currents;

        var size = MediaQuery.of(context).size;

        /*24 is for notification bar on Android*/
        final double itemHeight = (size.height - kToolbarHeight - 24) / 1.75;
        final double itemWidth = size.width / 2;

        return RefreshIndicator(
          onRefresh: _pullRefresh,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(currents.length, (index) {
              final book = currents[index];
              return Stack(children: <Widget>[
                Container(
                    height: size.height * 0.19,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage('${book.getBookThumbnail()}'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(6, 6), // changes position of shadow
                        ),
                      ],
                    ),
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
                        Navigator.of(context)
                            .pushNamed("/bookDetails", arguments: book);
                      },
                      onLongPress: () {
                        //moveBookDialog.show(book, context);
                      },
                    )),
                Positioned(
                    top: size.height * 0.2,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("${book.getAuthor()}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 10.0, color: Color(0xff3D3D3D)),
                            textAlign: TextAlign.center),
                        Text("${book.getBookTitle()}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                color: Color(0xff3E3E3E)),
                            textAlign: TextAlign.center),
                      ],
                    )),
                /*Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/addRecommendation",
                          arguments: book.getBookId());
                    },
                  ),
                ),*/
              ]);
            }),
          ),
        );
      }

      if (state is CurrentItemsFailure) {
        return Container(
          decoration: BoxDecoration(color: Colors.red[800]),
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
                  //currentsBloc.add(LoadCurrentItems());
                },
              )
            ],
          )),
        );
      }

      return Text("Error");
    });
  }

  Future<void> _pullRefresh() async {
    BlocProvider.of<CurrentBloc>(context).add(LoadCurrentItems());
  }
}

/*
class CurrentsPageTest extends StatelessWidget {
  MoveBookDialog moveBookDialog;

  CurrentsPageTest() {
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
          //final currentsBloc = BlocProvider.of<CurrentBloc>(context);

          if (state is CurrentItemsLoading) {
            return Container(
              decoration: BoxDecoration(color: Color(0xffE9E8E3)),
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
              decoration: BoxDecoration(color: Color(0xffE9E8E3)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(45.0),
                            ),
                          ),
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search'),
                    ),
                  ),
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
              decoration: BoxDecoration(color: Colors.red[800]),
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
*/