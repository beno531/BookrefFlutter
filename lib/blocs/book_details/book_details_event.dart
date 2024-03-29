import 'package:bookref/models/book.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BookDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBookDetails extends BookDetailsEvent {
  Book book;
  LoadBookDetails({@required this.book}) : assert(book != null);
}

class LoadBookRecommendations extends BookDetailsEvent {
  Book book;
  LoadBookRecommendations({@required this.book}) : assert(book != null);
}
