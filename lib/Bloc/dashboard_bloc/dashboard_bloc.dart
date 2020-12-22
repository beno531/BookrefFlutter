import 'dart:async';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_events.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDashboardBloc extends Bloc<MyDahsboardEvent, MyDashboardBooksState> {
  final BookrefRepository bookrefRepository;

  // this a bit of a hack
  List<Books> books;

  MyDashboardBloc({@required this.bookrefRepository}) : super(BooksLoading());

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
      yield BooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardCurrents();

      final wishlistQueryResults =
          await this.bookrefRepository.getDashboardWishlist();

      final libaryQueryResults =
          await this.bookrefRepository.getDashboardLibary();

      if (currentsQueryResults.hasException) {
        yield BooksNotLoaded(currentsQueryResults.exception.graphqlErrors);
        return;
      } else if (wishlistQueryResults.hasException) {
        yield BooksNotLoaded(wishlistQueryResults.exception.graphqlErrors);
        return;
      } else if (libaryQueryResults.hasException) {
        yield BooksNotLoaded(libaryQueryResults.exception.graphqlErrors);
        return;
      }

/*
      final List<dynamic> repos = queryResults.data['books'] as List<dynamic>;

      final List<Books> listOfbooks = repos
          .map((dynamic e) => Books(
              isbn: e['isbn'] as String,
              book: Book(
                  title: e["book"]["title"] as String,
                  bookAuthors: BookAuthors(
                      author: Author(
                          name: e["book"]["bookAuthors"][0]["author"]
                              ["name"])))))
          .toList();

      books = listOfbooks;

      */

      //print(queryResults.data['books']);

      final List<dynamic> currentBooks = currentsQueryResults.data['books'];

      final List<dynamic> wishlistBooks = wishlistQueryResults.data['books'];

      final List<dynamic> libaryBooks = libaryQueryResults.data['books'];

      // pass the data instead
      /// Muss angepasst werden
      ///
      ///
      yield BooksLoaded(
          currents: currentBooks, wishlist: wishlistBooks, libary: libaryBooks);
    } catch (error) {
      yield BooksNotLoaded(error);
    }
  }
}
