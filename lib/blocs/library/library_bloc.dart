import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_authentication/blocs/library/library_event.dart';
import 'package:flutter_bloc_authentication/blocs/library/library_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';
import '../../services/services.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final DataService dataService;

  LibraryBloc({@required this.dataService}) : super(LibraryItemsLoading());

  @override
  Stream<LibraryState> mapEventToState(LibraryEvent event) async* {
    if (event is LoadLibraryItems) {
      yield* _mapLoadWishlistItemsToState(event);
    }
  }

  Stream<LibraryState> _mapLoadWishlistItemsToState(
      LoadLibraryItems event) async* {
    print("Load Library Items");
    try {
      List<Book> libraryBooks = await dataService.getLibraryBooks();
      if (libraryBooks != null) {
        yield LibraryItemsFinished(library: libraryBooks);
      } else {
        yield LibraryItemsFailure(
            message: 'Something very weird just happened');
      }
    } catch (err) {
      yield LibraryItemsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
