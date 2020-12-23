import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyCurrentsState extends Equatable {
  MyCurrentsState([List props = const []]) : super(props);
}

class CurrentBooksLoading extends MyCurrentsState {
  @override
  String toString() => 'BooksLoading';
}

class CurrentBooksLoaded extends MyCurrentsState {
  final List<Books> currents;

  CurrentBooksLoaded({@required this.currents});
}

class CurrentBooksNotLoaded extends MyCurrentsState {
  final List<GraphQLError> errors;

  CurrentBooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
