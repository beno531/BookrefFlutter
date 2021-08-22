import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bookref/models/book.dart';
import 'package:bookref/blocs/currents/currents_event.dart';
import 'package:bookref/blocs/currents/currents_state.dart';
import 'package:flutter/cupertino.dart';
import '../../services/services.dart';

class CurrentBloc extends Bloc<CurrentsEvent, CurrentsState> {
  final DataService dataService;

  CurrentBloc({@required this.dataService}) : super(CurrentItemsLoading());

  @override
  Stream<CurrentsState> mapEventToState(CurrentsEvent event) async* {
    if (event is LoadCurrentItems) {
      yield* _mapLoadCurrentItemsToState(event);
    }
  }

  Stream<CurrentsState> _mapLoadCurrentItemsToState(
      LoadCurrentItems event) async* {
    log("Bis hier kommts");
    yield CurrentItemsLoading();
    try {
      await Future.delayed(Duration(seconds: 1), () {}); // Vorerst gefixt
      List<Book> currentBooks = await dataService.getCurrentBooks();
      log("Hier geht auch!");
      print("Load Current Items");

      if (currentBooks != null) {
        yield CurrentItemsFinished(currents: currentBooks);
      } else {
        yield CurrentItemsFailure(
            message: 'Something very weird just happened');
      }
    } catch (err) {
      yield CurrentItemsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
