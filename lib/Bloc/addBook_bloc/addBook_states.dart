import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyAddBookState extends Equatable {
  MyAddBookState([List props = const []]) : super(props);
}

class AddBookFinishedState extends MyAddBookState {
  final String error;
  final String data;

  AddBookFinishedState({this.data, this.error});
}
