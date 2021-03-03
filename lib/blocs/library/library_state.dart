import 'package:flutter_bloc_authentication/models/book.dart';
import 'package:flutter_bloc_authentication/models/dashboardBooks.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';

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
