import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RemoveBookState extends Equatable {
  @override
  List<Object> get props => [];
}

class RemoveBookLoading extends RemoveBookState {}

class RemoveBookFinished extends RemoveBookState {}

class RemoveBookFailure extends RemoveBookState {
  final String message;
  RemoveBookFailure({@required this.message});
}
