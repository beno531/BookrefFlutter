import 'package:bookref/Router/router.gr.dart';
import 'package:bookref/models/book.dart';
import 'package:bookref/blocs/library/library_bloc.dart';
import 'package:bookref/blocs/library/library_event.dart';
import 'package:bookref/blocs/library/library_state.dart';
import 'package:bookref/services/data_service.dart';
import 'package:bookref/widgets/moveBookDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
                top: size.height * 0.04,
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
                "LIBRARY",
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
                child: _LibraryBooksDisplay(),
              ),
            )
          ],
        ));
  }
}

class _LibraryBooksDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LibraryBloc(
              dataService: DataService(),
            ),
        child: _LibraryBooks());
  }
}

class _LibraryBooks extends StatefulWidget {
  @override
  __LibraryBooksState createState() => __LibraryBooksState();
}

class __LibraryBooksState extends State<_LibraryBooks> {
  MoveBookDialog moveBookDialog;
  __LibraryBooksState() {
    moveBookDialog = MoveBookDialog();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LibraryBloc>(context).add(LoadLibraryItems());

    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      //final currentsBloc = BlocProvider.of<CurrentBloc>(context);

      if (state is LibraryItemsLoading) {
        return Container(
          decoration: BoxDecoration(color: Color(0xffE9E8E3)),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is LibraryItemsFinished) {
        final List<Book> librarys = state.library;

        var size = MediaQuery.of(context).size;

        final double itemHeight = (size.height - kToolbarHeight - 24) / 1.75;
        final double itemWidth = size.width / 2;

        return RefreshIndicator(
          onRefresh: _pullRefresh,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(librarys.length, (index) {
              final book = librarys[index];
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
                        context.router.push(
                          BookDetailsRoute(book: book),
                        );
                      },
                      onLongPress: () {
                        moveBookDialog.show(book, context);
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
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onTap: () {
                      context.router.push(
                        AddRecommendationRoute(bookId: book.getBookId()),
                      );
                    },
                  ),
                ),
              ]);
            }),
          ),
        );
      }

      if (state is LibraryItemsFailure) {
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
    BlocProvider.of<LibraryBloc>(context).add(LoadLibraryItems());
  }
}
