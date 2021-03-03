import 'package:flutter_bloc_authentication/models/book.dart';
import 'package:flutter_bloc_authentication/models/dashboardBooks.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';

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
