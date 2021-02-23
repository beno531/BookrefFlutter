import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_events.dart';
import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyBooksDetailsBloc extends Bloc<MyBookDetailsEvent, MyBookDetailsState> {
  final BookrefRepository bookrefRepository;
  final dynamic book;

  MyBooksDetailsBloc({@required this.bookrefRepository, @required this.book})
      : super(null);

  @override
  Stream<MyBookDetailsState> mapEventToState(
    MyBookDetailsEvent event,
  ) async* {
    try {
      if (event is LoadPersonRecEvent) {
        yield LoadingPersonRecState();
        Books currentBook = book;

        QueryResult resultperson = await bookrefRepository
            .getPeopleRecommendationsForBook(currentBook.getBookId());

        QueryResult resultbook = await bookrefRepository
            .getBookRecommendationsForBook(currentBook.getBookId());

        yield LoadPersonRecFinishedState(
            persons: resultperson.data['peopleRecommendationsForBook'],
            books: resultbook.data['bookRecommendationsForBook']);
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

/*
  String _convertDataResponse(QueryResult queryResult) {
    return queryResult.data['singIn']['data'];
  }
*/

  _extractPersonsId(QueryResult queryResult) async {
    try {
      return queryResult.data['people'][0]['id'];
    } catch (e) {
      return null;
    }
  }

  _extractExternalBookId(QueryResult queryResult) async {
    try {
      return queryResult.data['allBooks']['edges'][0]['node']['id'];
    } catch (e) {
      return null;
    }
  }

  String _convertErrorResponse(QueryResult queryResult) {
    try {
      return queryResult.data['singIn']['errors']['messages'];
    } catch (e) {
      return "";
    }
  }
}
