import 'package:bookref/Bloc/currents_bloc/currents_events.dart';
import 'package:bookref/Bloc/currents_bloc/currents_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyCurrentsBloc extends Bloc<MyCurrentEvent, MyCurrentsState> {
  final BookrefRepository bookrefRepository;

  MyCurrentsBloc({@required this.bookrefRepository})
      : super(CurrentBooksLoading());

  @override
  Stream<MyCurrentsState> mapEventToState(
    MyCurrentEvent event,
  ) async* {
    try {
      if (event is LoadMyCurrentBooks) {
        yield* _mapCurrentBooksToState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  Stream<MyCurrentsState> _mapCurrentBooksToState() async* {
    try {
      yield CurrentBooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardCurrents();

      if (currentsQueryResults.hasException) {
        yield CurrentBooksNotLoaded(
            currentsQueryResults.exception.graphqlErrors);
        return;
      }

      yield CurrentBooksLoaded(
          currents: _convertQueryToList(currentsQueryResults));
    } catch (error) {
      yield CurrentBooksNotLoaded(error);
    }
  }

  List<Books> _convertQueryToList(QueryResult queryResult) {
    var listBooks = List<Books>();

    for (var i = 0; i < queryResult.data["books"].length; i++) {
      listBooks.add(
        Books(queryResult.data["books"][i]),
      );
    }

    return listBooks;
  }
}
