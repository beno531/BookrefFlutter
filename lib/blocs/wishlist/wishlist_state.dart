import 'package:bookref/models/book.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class WishlistItemsLoading extends WishlistState {}

class WishlistItemsFinished extends WishlistState {
  final List<Book> wishlist;
  WishlistItemsFinished({@required this.wishlist});
}

class WishlistItemsFailure extends WishlistState {
  final String message;
  WishlistItemsFailure({@required this.message});
}
