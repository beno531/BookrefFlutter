import 'package:bookref/blocs/remove_book.dart/remove_book_event.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_state.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveBookBloc extends Bloc<RemoveBookEvent, RemoveBookState> {
  final DataService dataService;

  RemoveBookBloc({@required this.dataService}) : super(RemoveBookInitial());

  @override
  Stream<RemoveBookState> mapEventToState(RemoveBookEvent event) async* {
    if (event is RemoveBook) {
      yield* _mapRemoveBookToState(event);
    }
  }

  Stream<RemoveBookState> _mapRemoveBookToState(RemoveBook event) async* {
    yield RemoveBookLoading();
    try {
      var result = await dataService.removeBook(event.personalBookId);
      yield RemoveBookFinished();
    } catch (err) {
      yield RemoveBookFailure(message: err.toString() ?? "Error");
    }
  }
}
