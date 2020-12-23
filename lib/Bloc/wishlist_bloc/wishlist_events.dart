import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyWishlistEvent extends Equatable {
  MyWishlistEvent([List props = const []]) : super(props);
}

class LoadMyWishlistBooks extends MyWishlistEvent {
  @override
  String toString() => 'LoadMyWishlist';
}
