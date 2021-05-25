import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'add_book_event.dart';
import 'add_book_state.dart';
import '../../services/services.dart';

class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  final DataService dataService;

  AddBookBloc({@required this.dataService}) : super(AddBookInitial());

  @override
  Stream<AddBookState> mapEventToState(AddBookEvent event) async* {
    if (event is AddBookButtonPressed) {
      yield* _mapAddBookToState(event);
    }
  }

  Stream<AddBookState> _mapAddBookToState(AddBookButtonPressed event) async* {
    yield AddBookLoading();
    try {
      if (event.id == null) {
        final addBookResult = await dataService.addBook(
            event.identifier, event.title, event.subtitle);

        await dataService.moveBookInLibrary(
            addBookResult.getBookDataId(), event.status);

        final author = await dataService.checkAuthorName(event.author);

        if (author != null) {
          // Setze Referenz zu bestehendem Autor
          await dataService.addAuthor(
              addBookResult.getBookDataId(), author['id']);
        } else {
          // Erstelle neuen Autor mit Referenz
          await dataService.addNewAuthor(
              addBookResult.getBookDataId(), event.author);
        }
      } else {
        await dataService.moveBookInLibrary(event.id, event.status);
      }

      yield AddBookSuccess();
      yield AddBookInitial();
    } catch (err) {
      yield AddBookFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
