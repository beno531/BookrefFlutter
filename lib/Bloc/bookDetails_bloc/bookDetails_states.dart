import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyBookDetailsState extends Equatable {
  MyBookDetailsState([List props = const []]) : super(props);
}

class LoadingPersonRecState extends MyBookDetailsState {}

class LoadPersonRecFinishedState extends MyBookDetailsState {
  final dynamic error;
  final dynamic persons;
  final dynamic books;

  LoadPersonRecFinishedState(
      {@required this.persons, @required this.books, this.error});
}

class PersonRecNotLoadedState extends MyBookDetailsState {}

class LoadingBookRecState extends MyBookDetailsState {}

class LoadBookRecFinishedState extends MyBookDetailsState {
  final dynamic error;
  final dynamic data;

  LoadBookRecFinishedState({@required this.data, this.error});
}

class BookRecNotLoadedState extends MyBookDetailsState {}
