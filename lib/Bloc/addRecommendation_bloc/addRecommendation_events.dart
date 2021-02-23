import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyAddRecommendationEvent extends Equatable {
  MyAddRecommendationEvent([List props = const []]) : super(props);
}

class AddPersonRecEvent extends MyAddRecommendationEvent {
  final String person;
  final String notes;

  AddPersonRecEvent({@required this.person, this.notes})
      : assert(person.isEmpty == false);
}

class AddBookRecEvent extends MyAddRecommendationEvent {
  final String identifier;
  final String title;
  final String notes;

  AddBookRecEvent({@required this.identifier, @required this.title, this.notes})
      : assert(identifier.isEmpty == false && title.isEmpty == false);
}
