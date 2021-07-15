import 'package:bloc/bloc.dart';
import 'package:bookref/blocs/book_details/book_details_event.dart';
import 'package:bookref/blocs/book_details/book_details_state.dart';
import 'package:bookref/models/recommendedBook.dart';
import 'package:bookref/models/recommendedPerson.dart';
import 'package:bookref/models/testbook.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final DataService dataService;

  BookDetailsBloc({@required this.dataService}) : super(BookDetailsLoading());

  @override
  Stream<BookDetailsState> mapEventToState(BookDetailsEvent event) async* {
    if (event is LoadBookDetails) {
      yield* _mapLoadBookDetailsToState(event);
    }
  }

  Stream<BookDetailsState> _mapLoadBookDetailsToState(
      LoadBookDetails event) async* {
    print("Load Book Details");
    try {
      // Full Book
      DetailsBook book =
          await dataService.getFullBookById(event.book.getBookId());
      // Buch Recommandations
      List<RecommendedBook> bookRec = await dataService
          .getBookRecommendationsForBook(event.book.getBookId());
      // Person Recommendations
      List<RecommendedPerson> personRec = await dataService
          .getPeopleRecommendationsForBook(event.book.getBookId());

      yield BookDetailsFinished(
          book: book,
          bookRecommendation: bookRec,
          personRecommendation: personRec);
    } catch (err) {
      yield BookDetailsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
