import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWishlistItems extends WishlistEvent {}
