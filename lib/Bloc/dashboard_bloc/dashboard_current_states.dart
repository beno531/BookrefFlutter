import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyDashboardBooksState extends Equatable {
  MyDashboardBooksState([List props = const []]) : super(props);
}

class DashboardBooksLoading extends MyDashboardBooksState {
  @override
  String toString() => 'BooksLoading';
}

class DashboardBooksLoaded extends MyDashboardBooksState {
  final List<Books> currents;
  final List<Books> wishlist;
  final List<Books> libary;

  DashboardBooksLoaded(
      {@required this.currents,
      @required this.wishlist,
      @required this.libary});
}

class DashboardBooksNotLoaded extends MyDashboardBooksState {
  final List<GraphQLError> errors;

  DashboardBooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
