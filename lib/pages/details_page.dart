import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/book_details/book_details_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/book_details/book_details_event.dart';
import 'package:flutter_bloc_authentication/blocs/book_details/book_details_state.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_event.dart';
import 'package:flutter_bloc_authentication/models/book.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  const BookDetailsPage({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookDetailsBloc>(context).add(LoadBookDetails(book: book));
    return BlocBuilder<BookDetailsBloc, BookDetailsState>(
        builder: (context, state) {
      final bookDetailsBloc = BlocProvider.of<BookDetailsBloc>(context);

      if (state is BookDetailsLoading) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is BookDetailsFinished) {
        //final Book book = state.bookDetails.book;
        ////final List<Book> wishlist = state.dashboardBooks.wishlist;
        ////final List<Book> libary = state.dashboardBooks.library;

        return SafeArea(
          child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: ListView(
                        children: <Widget>[
                          CustomListTile(
                              "Title", book.getBookTitle() ?? "none"),
                          CustomListTile(
                              "Subtitle", book.getBookSubtitle() ?? "none"),
                          CustomListTile("Author", book.getAuthor() ?? "none"),
                          //CustomListTile("Sprache", books.getBookLang()),
                          //CustomListTile("ISBN", books.getBookIsbn()),
                          //CustomListTile("Kategorien", "#Kommt später ;)"),
                          //CustomListTile("Aktuelle Seite", books.getBookCurrentPage().toString()),
                          //CustomListTile("Erstellt am", books.getBookCreated()),
                        ],
                      ),
                    ),
                    Text("Recommended Books",
                        style: TextStyle(color: Colors.white)),
                    // Container(
                    //     height: 210,
                    //     child: new DisplayBookRec(
                    //         bloc:
                    //             BlocProvider.of<MyBooksDetailsBloc>(context))),
                    Text("Recommended Persons",
                        style: TextStyle(color: Colors.white)),
                    // Container(
                    //   height: 200,
                    //   child: new DisplayBookPersonRec(
                    //       bloc: BlocProvider.of<MyBooksDetailsBloc>(context)),
                    // ),
                  ],
                ),
              )),
        );
      }

      if (state is BookDetailsFailure) {
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
                  bookDetailsBloc.add(LoadBookDetails(book: book));
                },
              )
            ],
          )),
        );
      }
    });
  }
}

class CustomListTile extends StatelessWidget {
  String title;
  String subtitle;

  CustomListTile(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
