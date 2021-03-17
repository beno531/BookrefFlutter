import 'package:bookref/blocs/move_book.dart/move_book_event.dart';
import 'package:bookref/blocs/move_book.dart/move_book_state.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveBookBloc extends Bloc<MoveBookEvent, MoveBookState> {
  final DataService dataService;

  MoveBookBloc({@required this.dataService}) : super(null);

  @override
  Stream<MoveBookState> mapEventToState(MoveBookEvent event) async* {
    if (event is MoveBook) {
      yield* _mapMoveBookToState(event);
    }
  }

  Stream<MoveBookState> _mapMoveBookToState(MoveBook event) async* {
    yield MoveBookLoading();
    try {
      var result = await dataService.changeBookStatus(
          event.personalBookId, event.newStatus);
      yield MoveBookFinished();
    } catch (err) {
      yield MoveBookFailure(message: err.toString() ?? "Error");
    }
  }
}
