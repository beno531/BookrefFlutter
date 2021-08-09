import 'package:bookref/models/book.dart';
import 'package:bookref/themes/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  const BookDetailsPage({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<BookDetailsBloc>(context).add(LoadBookDetails(book: bookRef));
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        body: Container(
            width: size.width,
            height: size.height,
            child: Stack(children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.6,
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            spreadRadius: 15,
                            blurRadius: 50,
                            offset: Offset(0, 0), // changes position of shadow
                          )
                        ]),
                  )),
              Positioned(
                top: size.height * 0.05,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: size.width * 0.03,
                        top: size.height * 0.004,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.065,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: size.height * 0.3,
                        width: size.width * 0.36,
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
                              spreadRadius: 5,
                              blurRadius: 25,
                              offset:
                                  Offset(6, 6), // changes position of shadow
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Positioned(
                  top: size.height * 0.40,
                  left: 30,
                  right: 30,
                  child: Container(
                      height: 313,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontSize: 37.0,
                                  color: Colors.grey[800],
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: '${book.getBookTitle()}',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.grey[700],
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: '${book.getAuthor()}',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))),
            ])));
  }
}

/*

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
    });*/
