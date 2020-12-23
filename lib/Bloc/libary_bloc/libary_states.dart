import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLibaryState extends Equatable {
  MyLibaryState([List props = const []]) : super(props);
}

class LibaryBooksLoading extends MyLibaryState {
  @override
  String toString() => 'BooksLoading';
}

class LibaryBooksLoaded extends MyLibaryState {
  final List<Books> libary;

  LibaryBooksLoaded({@required this.libary});
}

class LibaryBooksNotLoaded extends MyLibaryState {
  final List<GraphQLError> errors;

  LibaryBooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
