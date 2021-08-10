import 'dart:developer';
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
    log(this.book.book.toString());
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
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('This is a snackbar')));
                      },
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
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                              child: Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              text: '${book.getBookTitle()}',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RichText(
                                      text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.grey[700],
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: '${book.getBookSubtitle()}',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RichText(
                                      text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 15.0,
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
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    "${book.getBookPublishedDate()}"),
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
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    "${book.getBookPageCount()}"),
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
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    "${book.getBookLang()}"),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        "SUMMARY:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey[800]),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                          child: Text(
                                              "${book.getBookTextSnippet()}"))),
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
}
