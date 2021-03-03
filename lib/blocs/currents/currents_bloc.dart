import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_authentication/blocs/currents/currents_event.dart';
import 'package:flutter_bloc_authentication/blocs/currents/currents_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';
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
    print("Load Current Items");
    try {
      List<Book> currentBooks = await dataService.getCurrentBooks();
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
