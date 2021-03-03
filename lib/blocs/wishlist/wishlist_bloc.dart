import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_authentication/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_bloc_authentication/blocs/wishlist/wishlist_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';
import '../../services/services.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final DataService dataService;

  WishlistBloc({@required this.dataService}) : super(WishlistItemsLoading());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is LoadWishlistItems) {
      yield* _mapLoadWishlistItemsToState(event);
    }
  }

  Stream<WishlistState> _mapLoadWishlistItemsToState(
      LoadWishlistItems event) async* {
    print("Load Wishlist Items");
    try {
      List<Book> wishlistBooks = await dataService.getWishlistBooks();
      if (wishlistBooks != null) {
        yield WishlistItemsFinished(wishlist: wishlistBooks);
      } else {
        yield WishlistItemsFailure(
            message: 'Something very weird just happened');
      }
    } catch (err) {
      yield WishlistItemsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
