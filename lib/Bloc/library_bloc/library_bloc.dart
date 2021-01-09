import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookref/Bloc/library_bloc/library_events.dart';
import 'package:bookref/Bloc/library_bloc/library_states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyLibraryBloc extends Bloc<MyLibraryEvent, MyLibraryState> {
  final BookrefRepository bookrefRepository;

  MyLibraryBloc({@required this.bookrefRepository})
      : super(LibraryBooksLoading());

  @override
  Stream<MyLibraryState> mapEventToState(
    MyLibraryEvent event,
  ) async* {
    try {
      if (event is LoadMyLibraryBooks) {
        yield* _mapCurrentBooksToState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  Stream<MyLibraryState> _mapCurrentBooksToState() async* {
    try {
      yield LibraryBooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardLibary();

      if (currentsQueryResults.hasException) {
        yield LibraryBooksNotLoaded(
            currentsQueryResults.exception.graphqlErrors);
        return;
      }

      yield LibraryBooksLoaded(
          library: _convertQueryToList(currentsQueryResults));
    } catch (error) {
      yield LibraryBooksNotLoaded(error);
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
