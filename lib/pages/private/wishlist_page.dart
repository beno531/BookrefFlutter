import 'package:bookref/models/book.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_state.dart';
import 'package:bookref/blocs/wishlist/wishlist_bloc.dart';
import 'package:bookref/blocs/wishlist/wishlist_event.dart';
import 'package:bookref/blocs/wishlist/wishlist_state.dart';
import 'package:bookref/widgets/moveBookDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookref/blocs/currents/currents_bloc.dart';
import 'package:bookref/blocs/currents/currents_event.dart';
import 'package:bookref/blocs/currents/currents_state.dart';
import 'package:bookref/services/data_service.dart';

class WishlistPage extends StatelessWidget {
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
                "Wishlist",
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
        create: (context) => WishlistBloc(
              dataService: DataService(),
            ),
        child: _WishlistBooks());
  }
}

class _WishlistBooks extends StatefulWidget {
  @override
  ___WishlistBooksState createState() => ___WishlistBooksState();
}

class ___WishlistBooksState extends State<_WishlistBooks> {
  MoveBookDialog moveBookDialog;
  ___WishlistBooksState() {
    moveBookDialog = MoveBookDialog();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WishlistBloc>(context).add(LoadWishlistItems());
    final _wishlistBloc = BlocProvider.of<WishlistBloc>(context);

    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      //final currentsBloc = BlocProvider.of<CurrentBloc>(context);

      if (state is WishlistItemsLoading) {
        return Container(
          decoration: BoxDecoration(color: Color(0xffE9E8E3)),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is WishlistItemsFinished) {
        final List<Book> currents = state.wishlist;

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
                      Navigator.of(context).pushNamed("/addRecommendation",
                          arguments: book.getBookId());
                    },
                  ),
                ),
              ]);
            }),
          ),
        );
      }

      if (state is WishlistItemsFailure) {
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
    BlocProvider.of<WishlistBloc>(context).add(LoadWishlistItems());
  }
}
