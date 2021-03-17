import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MoveBookState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoveBookLoading extends MoveBookState {}

class MoveBookFinished extends MoveBookState {}

class MoveBookFailure extends MoveBookState {
  final String message;
  MoveBookFailure({@required this.message});
}
