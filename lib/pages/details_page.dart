import 'package:bookref/Models/book.dart';
import 'package:bookref/Models/testbook.dart';
import 'package:bookref/blocs/book_details/book_details_bloc.dart';
import 'package:bookref/blocs/book_details/book_details_event.dart';
import 'package:bookref/blocs/book_details/book_details_state.dart';
import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/widgets/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsPage extends StatelessWidget {
  final Book bookRef;
  const BookDetailsPage({Key key, @required this.bookRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookDetailsBloc>(context)
        .add(LoadBookDetails(book: bookRef));
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
        final DetailsBook book = state.book;
        ////final List<Book> wishlist = state.dashboardBooks.wishlist;
        ////final List<Book> libary = state.dashboardBooks.library;
        ///

        print(state.bookRecommendation.length);

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 100.0,
                backgroundColor: Colors.grey[900],
                titleSpacing: 25,
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Info"),
                    Tab(text: "Book Rec."),
                    Tab(text: "Person Rec."),
                  ],
                ),
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(ChangeNavigationOnMain(route: "/dashboard"));
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "BOOK DETAILS",
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                )),
            body: TabBarView(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.grey[800]),
                  child: ListView(
                    children: <Widget>[
                      CustomListTile("Title", book.getBookTitle() ?? "none"),
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
                Container(
                  decoration: BoxDecoration(color: Colors.grey[800]),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.bookRecommendation.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              state.bookRecommendation[index].getTitle() ??
                                  "None",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              state.bookRecommendation[index].getNote() ??
                                  "None",
                              style: TextStyle(color: Colors.white)),
                        );
                      }),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[800]),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.personRecommendation.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              state.personRecommendation[index].getName() ??
                                  "None",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              state.personRecommendation[index].getNote() ??
                                  "None",
                              style: TextStyle(color: Colors.white)),
                        );
                      }),
                ),
              ],
            ),
          ),
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
                  bookDetailsBloc.add(LoadBookDetails(book: bookRef));
                },
              )
            ],
          )),
        );
      }

      return Text("Error");
    });
  }
}
