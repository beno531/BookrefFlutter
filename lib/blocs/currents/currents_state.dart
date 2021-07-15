import 'package:bookref/models/book.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentItemsLoading extends CurrentsState {}

class CurrentItemsFinished extends CurrentsState {
  final List<Book> currents;
  CurrentItemsFinished({@required this.currents});
}

class CurrentItemsFailure extends CurrentsState {
  final String message;
  CurrentItemsFailure({@required this.message});
}
