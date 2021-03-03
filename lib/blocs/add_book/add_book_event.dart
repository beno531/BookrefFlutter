import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddBookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddBookButtonPressed extends AddBookEvent {
  final String status;
  final String identifier;
  final String title;
  final String subtitle;
  final String author;

  AddBookButtonPressed(
      {@required this.status,
      @required this.identifier,
      @required this.title,
      @required this.subtitle,
      @required this.author})
      : assert(status.isEmpty == false &&
            identifier.isEmpty == false &&
            title.isEmpty == false &&
            author.isEmpty == false);
}
