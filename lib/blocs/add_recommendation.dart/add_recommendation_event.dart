import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecommendationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddBookRecommendationButtonPressed extends AddRecommendationEvent {
  final String identifier;
  final String title;
  final String notes;

  AddBookRecommendationButtonPressed(
      {@required this.identifier, @required this.title, this.notes})
      : assert(identifier.isEmpty == false && title.isEmpty == false);
}

class AddPersonRecommendationButtonPressed extends AddRecommendationEvent {
  final String person;
  final String notes;

  AddPersonRecommendationButtonPressed({@required this.person, this.notes})
      : assert(person.isEmpty == false);
}
