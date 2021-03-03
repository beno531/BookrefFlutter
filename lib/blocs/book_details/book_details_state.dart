import 'package:flutter_bloc_authentication/models/book.dart';
import 'package:flutter_bloc_authentication/models/recommendedPerson.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BookDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsFinished extends BookDetailsState {
  final Book book;
  final Book bookRecommendation;
  final RecommendedPerson personRecommendation;
  BookDetailsFinished(
      {@required this.book,
      @required this.bookRecommendation,
      @required this.personRecommendation});
}

class BookDetailsFailure extends BookDetailsState {
  final String message;
  BookDetailsFailure({@required this.message});
}
