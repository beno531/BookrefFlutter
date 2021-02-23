import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_bloc.dart';
import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_events.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/Pages/BookDetails/displayBookPersonRec.dart';
import 'package:bookref/Pages/BookDetails/displayBookRec.dart';
import 'package:bookref/widgets/bookDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsPage extends StatefulWidget {
  final book;
  BookDetailsPage(this.book);
  @override
  _BookDetailsPage createState() => _BookDetailsPage(this.book);
}

final titleInputController = TextEditingController();
final identifierInputController = TextEditingController();
final bookNotesInputController = TextEditingController();

final personInputController = TextEditingController();
final personNotesInputController = TextEditingController();

class _BookDetailsPage extends State<BookDetailsPage> {
  Books book;
  _BookDetailsPage(this.book);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyBooksDetailsBloc>(context)
        .add(LoadPersonRecEvent(bookId: book.getBookId()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAILS VIEW"),
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: ListView(
                      children: <Widget>[
                        CustomListTile("Title", book.getBookTitle() ?? "none"),
                        CustomListTile(
                            "Subtitle", book.getBookSubtitle() ?? "none"),
                        //CustomListTile("Author", books.getAuthor()),
                        //CustomListTile("Sprache", books.getBookLang()),
                        //CustomListTile("ISBN", books.getBookIsbn()),
                        //CustomListTile("Kategorien", "#Kommt später ;)"),
                        //CustomListTile("Aktuelle Seite", books.getBookCurrentPage().toString()),
                        //CustomListTile("Erstellt am", books.getBookCreated()),
                      ],
                    ),
                  ),
                  Text("Recommended Persons",
                      style: TextStyle(color: Colors.white)),
                  Container(
                    height: 200,
                    child: new DisplayBookPersonRec(
                        bloc: BlocProvider.of<MyBooksDetailsBloc>(context)),
                  ),
                  Text("Recommended Books",
                      style: TextStyle(color: Colors.white)),
                  Container(
                      height: 210,
                      child: new DisplayBookRec(
                          bloc: BlocProvider.of<MyBooksDetailsBloc>(context))),
                ],
              ),
            )),
      ),
    );
  }
}

class PersonRecManager extends StatefulWidget {
  final Books book;
  PersonRecManager(this.book);
  @override
  _PersonRecManager createState() => _PersonRecManager(this.book);
}

class _PersonRecManager extends State<PersonRecManager> {
  Books book;
  _PersonRecManager(this.book);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyBooksDetailsBloc>(context)
        .add(LoadPersonRecEvent(bookId: book.getBookId()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DisplayBookPersonRec(
        bloc: BlocProvider.of<MyBooksDetailsBloc>(context));
  }
}
