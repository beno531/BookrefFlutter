import 'package:bookref/Models/books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final Books books = arguments['book'];

    print(arguments['book']);

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
              CustomListTile("Title", books.getBookTitle()),
              CustomListTile("Author", books.getAuthor()),
              CustomListTile("Sprache", books.getBookLang()),
              CustomListTile("ISBN", books.getBookIsbn()),
              CustomListTile("Kategorien", "#Kommt später"),
              CustomListTile(
                  "Aktuelle Seite", books.getBookCurrentPage().toString()),
              CustomListTile("Erstellt am", books.getBookCreated()),
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
