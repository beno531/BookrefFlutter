import 'package:bookref/blocs/book_details/book_details_bloc.dart';
import 'package:bookref/blocs/book_details/book_details_event.dart';
import 'package:bookref/blocs/book_details/book_details_state.dart';
import 'package:bookref/models/book.dart';
import 'package:bookref/services/data_service.dart';
import 'package:bookref/themes/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_share/social_share.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  const BookDetailsPage({Key key, @required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookDetailsBloc(dataService: DataService()),
        child: BookDetailsPageDisplay(
          book: this.book,
        ));
  }
}

class BookDetailsPageDisplay extends StatelessWidget {
  final Book book;
  const BookDetailsPageDisplay({Key key, @required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookDetailsBloc>(context)
        .add(LoadBookDetails(book: this.book));
    final _currentsBloc = BlocProvider.of<BookDetailsBloc>(context);

    return BlocBuilder<BookDetailsBloc, BookDetailsState>(
        builder: (context, state) {
      if (state is BookDetailsLoading) {
        return Container(
          decoration: BoxDecoration(color: AppColors.background),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is BookDetailsFinished) {
        final size = MediaQuery.of(context).size;
        return Scaffold(
            backgroundColor: Color(0xffF3F3F3),
            body: Container(
                width: size.width,
                height: size.height,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(
                        'BOOK DETAILS',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      backgroundColor: Color(0xffF3F3F3),
                      expandedHeight: size.height * 0.36,
                      iconTheme: IconThemeData(color: Colors.black),
                      actions: [
                        PopupMenuButton(
                          icon: Icon(Icons
                              .share), //don't specify icon if you want 3 dot menu
                          color: Colors.blue,
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text(
                                "Copy to Clipboard",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text(
                                "Share via WhatsApp",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          onSelected: (item) => {onShareBook(item, book)},
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: Container(
                                  height: size.height * 0.25,
                                  width: size.width * 0.32,
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                      bottomLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${book.getBookThumbnail()}'),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        spreadRadius: 5,
                                        blurRadius: 25,
                                        offset: Offset(
                                            6, 6), // changes position of shadow
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              decoration: new BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 25, 25, 0),
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: RichText(
                                          text: new TextSpan(
                                            style: new TextStyle(
                                              fontSize: 37.0,
                                              color: Colors.grey[800],
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                      '${book.getBookTitle()}',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800)),
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
                                                  text:
                                                      book.getBookSubtitle() ??
                                                          "none",
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: RichText(
                                          text: new TextSpan(
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey[700],
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: book.getAuthor() ??
                                                      "none",
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Container(
                                          width: double.infinity,
                                          height: size.height * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "RELEASE",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                        book.getBookPublishedDate() ??
                                                            "none"),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  height: 60,
                                                  child: VerticalDivider(
                                                      color: Colors.grey)),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "PAGES",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                        book.getBookPageCount() ??
                                                            "none"),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  height: 60,
                                                  child: VerticalDivider(
                                                      color: Colors.grey)),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "LANGUAGE",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                        book.getBookLang() ??
                                                            "none"),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          child: Text(
                                            "SUMMARY:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey[800]),
                                          )),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                              child: Text(
                                                  book.getBookTextSnippet() ??
                                                      "none"))),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: DefaultTabController(
                                            length: 2, // length of tabs
                                            initialIndex: 0,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Container(
                                                    child: TabBar(
                                                      labelColor: Colors.orange,
                                                      unselectedLabelColor:
                                                          Colors.black,
                                                      tabs: [
                                                        Tab(text: 'Book Rec.'),
                                                        Tab(
                                                            text:
                                                                'Person Rec.'),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      height:
                                                          400, //height of TabBarView
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.5))),
                                                      child: TabBarView(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Center(
                                                                  child: state
                                                                          .bookRecommendation
                                                                          .isNotEmpty
                                                                      ? ListView.builder(
                                                                          padding: const EdgeInsets.all(8),
                                                                          itemCount: state.bookRecommendation.length,
                                                                          itemBuilder: (BuildContext context, int index) {
                                                                            return ListTile(
                                                                              title: Text(state.bookRecommendation[index].getTitle() ?? "None", style: TextStyle(color: Colors.grey[900])),
                                                                              subtitle: Text(state.bookRecommendation[index].getNote() ?? "None", style: TextStyle(color: Colors.grey[800])),
                                                                            );
                                                                          })
                                                                      : Text("No Data")),
                                                            ),
                                                            Container(
                                                              child: Center(
                                                                  child: state
                                                                          .bookRecommendation
                                                                          .isNotEmpty
                                                                      ? ListView.builder(
                                                                          padding: const EdgeInsets.all(8),
                                                                          itemCount: state.personRecommendation.length,
                                                                          itemBuilder: (BuildContext context, int index) {
                                                                            return ListTile(
                                                                              title: Text(state.personRecommendation[index].getName() ?? "None", style: TextStyle(color: Colors.grey[900])),
                                                                              subtitle: Text(state.personRecommendation[index].getNote() ?? "None", style: TextStyle(color: Colors.grey[800])),
                                                                            );
                                                                          })
                                                                      : Text("No Data")),
                                                            ),
                                                          ]))
                                                ])),
                                      ),
                                    ],
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
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
                  //bookDetailsBloc.add(LoadBookDetails(book: this.book));
                },
              )
            ],
          )),
        );
      }

      return Text("Error");
    });
  }

  onShareBook(itemIndex, Book book) {
    switch (itemIndex) {
      case 0:
        SocialShare.copyToClipboard(book.getBookTitle().toString() +
            " " +
            book.getBookSubtitle().toString() +
            ", " +
            book.getAuthor().toString());
        break;
      case 1:
        SocialShare.shareWhatsapp(book.getBookTitle().toString() +
            " " +
            book.getBookSubtitle().toString() +
            ", " +
            book.getAuthor().toString());
        break;
    }
  }
}
