import 'package:bookref/blocs/add_recommendation.dart/add_recommendation.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecommendationBloc
    extends Bloc<AddRecommendationEvent, AddRecommendationState> {
  final DataService dataService;
  final String bookId;

  AddRecommendationBloc({@required this.dataService, @required this.bookId})
      : super(AddRecommendationInitial());

  @override
  Stream<AddRecommendationState> mapEventToState(
      AddRecommendationEvent event) async* {
    if (event is AddBookRecommendationButtonPressed) {
      yield* _mapAddBookRecommendationToState(event);
    }

    if (event is AddPersonRecommendationButtonPressed) {
      yield* _mapAddPersonRecommendationToState(event);
    }
  }

  Stream<AddRecommendationState> _mapAddBookRecommendationToState(
      AddBookRecommendationButtonPressed event) async* {
    yield AddRecommendationLoading();
    try {
      dataService.addBookRecommendation(
          bookId, event.identifier, event.title, event.notes);

      //yield AddBookSuccess();
      yield AddRecommendationInitial();
    } catch (err) {
      yield AddRecommendationFailure(
          error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<AddRecommendationState> _mapAddPersonRecommendationToState(
      AddPersonRecommendationButtonPressed event) async* {
    yield AddRecommendationLoading();
    try {
      dataService.addPersonRecommendation(bookId, event.person, event.notes);

      //yield AddBookSuccess();
      yield AddRecommendationInitial();
    } catch (err) {
      yield AddRecommendationFailure(
          error: err.message ?? 'An unknown error occured');
    }
  }
}
