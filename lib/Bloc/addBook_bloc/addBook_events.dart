import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyAddBookEvent extends Equatable {
  MyAddBookEvent([List props = const []]) : super(props);
}

class AddBookEvent extends MyAddBookEvent {
  final String status;
  final String identifier;
  final String title;
  final String subtitle;
  final String author;

  AddBookEvent(
      {@required this.status,
      @required this.identifier,
      @required this.title,
      this.subtitle,
      @required this.author})
      : assert(status.isEmpty == false &&
            identifier.isEmpty == false &&
            title.isEmpty == false &&
            author.isEmpty == false);
}
