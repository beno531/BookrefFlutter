import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLibraryState extends Equatable {
  MyLibraryState([List props = const []]) : super(props);
}

class LibraryBooksLoading extends MyLibraryState {
  @override
  String toString() => 'BooksLoading';
}

class LibraryBooksLoaded extends MyLibraryState {
  final List<Books> library;

  LibraryBooksLoaded({@required this.library});
}

class LibraryBooksNotLoaded extends MyLibraryState {
  final List<GraphQLError> errors;

  LibraryBooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
