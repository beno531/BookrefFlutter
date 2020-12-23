import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookref/Bloc/libary_bloc/libary_events.dart';
import 'package:bookref/Bloc/libary_bloc/libary_states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyLibaryBloc extends Bloc<MyLibaryEvent, MyLibaryState> {
  final BookrefRepository bookrefRepository;

  MyLibaryBloc({@required this.bookrefRepository})
      : super(LibaryBooksLoading());

  @override
  Stream<MyLibaryState> mapEventToState(
    MyLibaryEvent event,
  ) async* {
    try {
      if (event is LoadMyLibaryBooks) {
        yield* _mapCurrentBooksToState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  Stream<MyLibaryState> _mapCurrentBooksToState() async* {
    try {
      yield LibaryBooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardLibary();

      if (currentsQueryResults.hasException) {
        yield LibaryBooksNotLoaded(
            currentsQueryResults.exception.graphqlErrors);
        return;
      }

      yield LibaryBooksLoaded(
          libary: _convertQueryToList(currentsQueryResults));
    } catch (error) {
      yield LibaryBooksNotLoaded(error);
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
