import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyDashboardBooksState extends Equatable {
  MyDashboardBooksState([List props = const []]) : super(props);
}

class BooksLoading extends MyDashboardBooksState {
  @override
  String toString() => 'BooksLoading';
}

class BooksLoaded extends MyDashboardBooksState {
  final List<dynamic> currents;
  final List<dynamic> wishlist;
  final List<dynamic> libary;

  BooksLoaded(
      {@required this.currents,
      @required this.wishlist,
      @required this.libary});
}

class BooksNotLoaded extends MyDashboardBooksState {
  final List<GraphQLError> errors;

  BooksNotLoaded([this.errors]) : super([errors]);

  @override
  String toString() => 'BooksNotLoaded';
}
