import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyWishlistState extends Equatable {
  MyWishlistState([List props = const []]) : super(props);
}

class WishlistBooksLoading extends MyWishlistState {
  @override
  String toString() => 'BooksLoading';
}

class WishlistBooksLoaded extends MyWishlistState {
  final List<Books> wishlist;

  WishlistBooksLoaded({@required this.wishlist});
}

class WishlistBooksNotLoaded extends MyWishlistState {
  final List<GraphQLError> errors;

  WishlistBooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
