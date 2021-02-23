import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyAddRecommendationState extends Equatable {
  MyAddRecommendationState([List props = const []]) : super(props);
}

class AddPersonRecFinishedState extends MyAddRecommendationState {
  final String error;
  final String data;

  AddPersonRecFinishedState({this.data, this.error});
}

class AddBookRecFinishedState extends MyAddRecommendationState {
  final String error;
  final String data;

  AddBookRecFinishedState({this.data, this.error});
}
