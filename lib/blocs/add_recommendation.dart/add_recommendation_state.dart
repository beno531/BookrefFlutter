import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecommendationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddRecommendationInitial extends AddRecommendationState {}

class AddRecommendationLoading extends AddRecommendationState {}

class AddRecommendationSuccess extends AddRecommendationState {}

class AddRecommendationFailure extends AddRecommendationState {
  final String error;

  AddRecommendationFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
