import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWishlistItems extends WishlistEvent {}
