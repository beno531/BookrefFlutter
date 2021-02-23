import 'package:bookref/Bloc/addBook_bloc/addBook_events.dart';
import 'package:bookref/Bloc/addBook_bloc/addBook_states.dart';
import 'package:bookref/Bloc/addRecommendation_bloc/addRecommendation_events.dart';
import 'package:bookref/Bloc/addRecommendation_bloc/addRecommendation_states.dart';
import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/Bloc/login_bloc/login_states.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyAddRecommendationBloc
    extends Bloc<MyAddRecommendationEvent, MyAddRecommendationState> {
  final BookrefRepository bookrefRepository;
  final dynamic bookId;

  MyAddRecommendationBloc(
      {@required this.bookrefRepository, @required this.bookId})
      : super(null);

  @override
  Stream<MyAddRecommendationState> mapEventToState(
    MyAddRecommendationEvent event,
  ) async* {
    try {
      if (event is AddPersonRecEvent) {
        QueryResult person =
            await bookrefRepository.checkPersonName(event.person);

        if (await _extractPersonsId(person) == null) {
          person = await bookrefRepository.addPerson(event.person);

          final result = await bookrefRepository.addPersonRecommendation(bookId,
              await person.data['addPerson']['data']['id'], event.notes);
        } else {
          final result = await bookrefRepository.addPersonRecommendation(
              bookId, await _extractPersonsId(person), event.notes);
        }

        yield AddPersonRecFinishedState();
      } else if (event is AddBookRecEvent) {
        print(bookId);
        print(event.identifier);

        QueryResult book = await bookrefRepository.getBookByTitle(event.title);

        if (await _extractExternalBookId(book) == null) {
          book = await bookrefRepository.addBook(
              event.identifier, event.title, "Placeholder");

          final result = bookrefRepository.addBookRecommendation(
              bookId, book.data['addBook']['data']['id'], event.notes);
        } else {
          final result = bookrefRepository.addBookRecommendation(
              bookId, await _extractExternalBookId(book), event.notes);
        }

        yield AddBookRecFinishedState();
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
