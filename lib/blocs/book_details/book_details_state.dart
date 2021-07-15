import 'package:bookref/models/recommendedBook.dart';
import 'package:bookref/models/recommendedPerson.dart';
import 'package:bookref/models/testbook.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BookDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsFinished extends BookDetailsState {
  final DetailsBook book;
  final List<RecommendedBook> bookRecommendation;
  final List<RecommendedPerson> personRecommendation;
  BookDetailsFinished(
      {@required this.book,
      @required this.bookRecommendation,
      @required this.personRecommendation});
}

class BookDetailsFailure extends BookDetailsState {
  final String message;
  BookDetailsFailure({@required this.message});
}
