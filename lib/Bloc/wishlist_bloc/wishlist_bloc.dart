import 'package:bookref/Models/books.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_events.dart';
import 'package:bookref/Bloc/wishlist_bloc/wishlist_states.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyWishlistBloc extends Bloc<MyWishlistEvent, MyWishlistState> {
  final BookrefRepository bookrefRepository;

  MyWishlistBloc({@required this.bookrefRepository})
      : super(WishlistBooksLoading());

  @override
  Stream<MyWishlistState> mapEventToState(
    MyWishlistEvent event,
  ) async* {
    try {
      if (event is LoadMyWishlistBooks) {
        yield* _mapCurrentBooksToState();
      }
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  Stream<MyWishlistState> _mapCurrentBooksToState() async* {
    try {
      yield WishlistBooksLoading();

      final currentsQueryResults =
          await this.bookrefRepository.getDashboardWishlist();

      if (currentsQueryResults.hasException) {
        yield WishlistBooksNotLoaded(
            currentsQueryResults.exception.graphqlErrors);
        return;
      }

      yield WishlistBooksLoaded(
          wishlist: _convertQueryToList(currentsQueryResults));
    } catch (error) {
      yield WishlistBooksNotLoaded(error);
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
