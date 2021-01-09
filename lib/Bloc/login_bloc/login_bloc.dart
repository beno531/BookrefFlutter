import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/Bloc/login_bloc/login_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/Models/newUser.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyLoginBloc extends Bloc<MyLoginEvent, MyLoginState> {
  final BookrefRepository bookrefRepository;

  MyLoginBloc({@required this.bookrefRepository}) : super(null);

  @override
  Stream<MyLoginState> mapEventToState(
    MyLoginEvent event,
  ) async* {
    try {
      if (event is RegisterEvent) {
        print("Moin Servus Moin");
        var params = {
          'email': '${event.email}',
          'username': '${event.username}',
          'password': '${event.password}'
        };

        final result = await bookrefRepository.registerUser(params);

        yield RegisterFinishedState(error: _convertErrorResponse(result));
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  String _convertErrorResponse(QueryResult queryResult) {
    return queryResult.data['errors']['messages'];
  }

/*
  Stream<MyLoginState> _mapCurrentBooksToState() async* {
    try {
      yield LoginLoading();

      final register = await this.bookrefRepository.getDashboardWishlist();

      if (currentsQueryResults.hasException) {
        yield LoginNotLoaded(currentsQueryResults.exception.graphqlErrors);
        return;
      }

      yield LoginLoaded(user: _convertQueryToList(currentsQueryResults));
    } catch (error) {
      yield LoginNotLoaded(error);
    }
  }
  */

/*
  List<Books> _convertQueryToList(QueryResult queryResult) {
    var listBooks = List<Books>();

    for (var i = 0; i < queryResult.data["books"].length; i++) {
      listBooks.add(
        Books(queryResult.data["books"][i]),
      );
    }

    return listBooks;
  }
  */
}
