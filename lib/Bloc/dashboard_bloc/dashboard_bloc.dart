import 'dart:async';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_events.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyDashboardBloc extends Bloc<MyDahsboardEvent, MyDashboardBooksState> {
  final BookrefRepository bookrefRepository;

  MyDashboardBloc({@required this.bookrefRepository})
      : super(DashboardBooksLoading());

  @override
  Stream<MyDashboardBooksState> mapEventToState(
    MyDahsboardEvent event,
  ) async* {
    try {
      if (event is LoadMyDashboardBooks) {
        yield* _mapDashboardBooksToState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  Stream<MyDashboardBooksState> _mapDashboardBooksToState() async* {
    try {
      yield DashboardBooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardCurrents();

      final wishlistQueryResults =
          await this.bookrefRepository.getDashboardWishlist();

      final libaryQueryResults =
          await this.bookrefRepository.getDashboardLibary();

      if (currentsQueryResults.hasException) {
        yield DashboardBooksNotLoaded(
            currentsQueryResults.exception.graphqlErrors);
        return;
      } else if (wishlistQueryResults.hasException) {
        yield DashboardBooksNotLoaded(
            wishlistQueryResults.exception.graphqlErrors);
        return;
      } else if (libaryQueryResults.hasException) {
        yield DashboardBooksNotLoaded(
            libaryQueryResults.exception.graphqlErrors);
        return;
      }

      yield DashboardBooksLoaded(
          currents: _convertQueryToList(currentsQueryResults),
          wishlist: _convertQueryToList(wishlistQueryResults),
          libary: _convertQueryToList(libaryQueryResults));
    } catch (error) {
      yield DashboardBooksNotLoaded(error);
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
