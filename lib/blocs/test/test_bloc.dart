import 'package:bloc/bloc.dart';
import 'package:bookref/blocs/test/test_event.dart';
import 'package:bookref/blocs/test/test_state.dart';
import 'package:flutter/cupertino.dart';
import '../../services/services.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final DataService dataService;

  TestBloc({@required this.dataService}) : super(null);

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    // if (event is LoadCurrentItems) {
    //   yield* _mapLoadCurrentItemsToState(event);
    // }
  }

  // Stream<CurrentsState> _mapLoadCurrentItemsToState(
  //     LoadCurrentItems event) async* {
  //   yield CurrentItemsLoading();
  //   print("Load Current Items");
  //   try {
  //     List<Book> currentBooks = await dataService.getCurrentBooks();
  //     if (currentBooks != null) {
  //       yield CurrentItemsFinished(currents: currentBooks);
  //     } else {
  //       yield CurrentItemsFailure(
  //           message: 'Something very weird just happened');
  //     }
  //   } catch (err) {
  //     yield CurrentItemsFailure(
  //         message: err.message ?? 'An unknown error occured');
  //   }
  // }
}
