import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecommendationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddBookRecommendationButtonPressed extends AddRecommendationEvent {
  final String id;
  final String identifier;
  final String title;
  final String subtitle;
  final String author;
  final String notes;

  AddBookRecommendationButtonPressed(
      {this.id,
      this.identifier,
      this.title,
      this.subtitle,
      this.author,
      this.notes});
}

class AddPersonRecommendationButtonPressed extends AddRecommendationEvent {
  final String person;
  final String notes;

  AddPersonRecommendationButtonPressed({@required this.person, this.notes})
      : assert(person.isEmpty == false);
}
