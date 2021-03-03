import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddBookState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddBookInitial extends AddBookState {}

class AddBookLoading extends AddBookState {}

class AddBookSuccess extends AddBookState {}

class AddBookFailure extends AddBookState {
  final String error;

  AddBookFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
