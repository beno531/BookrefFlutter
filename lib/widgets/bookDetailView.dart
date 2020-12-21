import 'package:bookref/Models/books.dart';
import 'package:bookref/widgets/horizontalDashboardBookView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bookref/graphql/query.dart' as queries;

class BookDetailView extends StatefulWidget {
  Map<String, dynamic> arguments;
  BookDetailView(this.arguments);

  @override
  _BookDetailView createState() => _BookDetailView(this.arguments);
}

class _BookDetailView extends State<BookDetailView> {
  Map<String, dynamic> arguments;

  _BookDetailView(this.arguments);

  @override
  Widget build(BuildContext context) {
    final Books book = arguments['book'];

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAILS VIEW"),
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
          child: ListView(
            children: <Widget>[
              CustomListTile("Title", book.getBookTitle()),
              CustomListTile("Author", book.getAuthor()),
              CustomListTile("Sprache", book.getBookLang()),
              CustomListTile("ISBN", book.getBookIsbn()),
              CustomListTile("Kategorien", ""),
              CustomListTile(
                  "Aktuelle Seite", book.getBookCurrentPage().toString()),
              CustomListTile("Erstellt am", book.getBookCreated()),
            ],
          ),
        ),
      ),
    );
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

/*

Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: Column(
        children: <Widget>[new Text("${book.getBookTitle()}")],
      ),
    );



    */
