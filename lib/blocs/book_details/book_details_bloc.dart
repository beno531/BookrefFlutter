import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_authentication/blocs/book_details/book_details_event.dart';
import 'package:flutter_bloc_authentication/blocs/book_details/book_details_state.dart';
import 'package:flutter_bloc_authentication/models/book.dart';
import '../../services/services.dart';

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
      Book book = await dataService.getFullBookById(event.book.getBookId());
      // Buch Recommandations
      dynamic bookRec = await dataService
          .getBookRecommendationsForBook(event.book.getBookId());
      // Person Recommendations
      dynamic personRec = await dataService
          .getPeopleRecommendationsForBook(event.book.getBookId());

      print(bookRec.toString());

      yield BookDetailsFinished(book: book);
    } catch (err) {
      yield BookDetailsFailure(
          message: err.message ?? 'An unknown error occured');
    }
  }
}
