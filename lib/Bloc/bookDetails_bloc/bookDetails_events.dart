import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyBookDetailsEvent extends Equatable {
  MyBookDetailsEvent([List props = const []]) : super(props);
}

class LoadPersonRecEvent extends MyBookDetailsEvent {
  final String bookId;

  LoadPersonRecEvent({@required this.bookId}) : assert(bookId.isEmpty == false);
}

class LoadBookRecEvent extends MyBookDetailsEvent {
  final String bookId;

  LoadBookRecEvent({@required this.bookId}) : assert(bookId.isEmpty == false);
}
