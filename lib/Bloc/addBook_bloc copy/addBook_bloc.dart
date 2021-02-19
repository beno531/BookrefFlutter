import 'package:bookref/Bloc/addBook_bloc%20copy/addBook_events.dart';
import 'package:bookref/Bloc/addBook_bloc%20copy/addBook_states.dart';
import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/Bloc/login_bloc/login_states.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyAddBookBloc extends Bloc<MyAddBookEvent, MyAddBookState> {
  final BookrefRepository bookrefRepository;

  MyAddBookBloc({@required this.bookrefRepository}) : super(null);

  @override
  Stream<MyAddBookState> mapEventToState(
    MyAddBookEvent event,
  ) async* {
    try {
      if (event is AddBookEvent) {
        final addBookResult = await bookrefRepository.addBook(
            event.identifier, event.title, event.subtitle);

        final bookId = await _extractBookId(addBookResult);

        final result =
            await bookrefRepository.moveBookInLibrary(bookId, event.status);

        final authors = await bookrefRepository.checkAuthorName(event.author);

        if (await _extractAuthorsName(authors) != null) {
          // Setze Referenz zu bestehendem Autor
          print("Autor ist vorhanden!");
          print(bookId.toString());
          print(await _extractAuthorsId(authors));
          await bookrefRepository.addAuthor(
              bookId, await _extractAuthorsId(authors));
        } else {
          // Erstelle neuen Autor mit Referenz
          print("Autor ist nicht vorhanden!");
          await bookrefRepository.addNewAuthor(bookId, event.author);
        }

        yield AddBookFinishedState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

/*
  String _convertDataResponse(QueryResult queryResult) {
    return queryResult.data['singIn']['data'];
  }
*/

  _extractBookId(QueryResult queryResult) async {
    return queryResult.data['addBook']['data']['id'];
  }

  _extractAuthorsName(QueryResult queryResult) async {
    try {
      return queryResult.data['authors'][0]['name'];
    } catch (e) {
      return null;
    }
  }

  _extractAuthorsId(QueryResult queryResult) async {
    return queryResult.data['authors'][0]['id'];
  }

  String _convertErrorResponse(QueryResult queryResult) {
    try {
      return queryResult.data['singIn']['errors']['messages'];
    } catch (e) {
      return "";
    }
  }
}
