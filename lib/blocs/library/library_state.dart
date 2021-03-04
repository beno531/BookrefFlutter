import 'package:bookref/Models/book.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class LibraryState extends Equatable {
  @override
  List<Object> get props => [];
}

class LibraryItemsLoading extends LibraryState {}

class LibraryItemsFinished extends LibraryState {
  final List<Book> library;
  LibraryItemsFinished({@required this.library});
}

class LibraryItemsFailure extends LibraryState {
  final String message;
  LibraryItemsFailure({@required this.message});
}
