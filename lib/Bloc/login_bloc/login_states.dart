import 'package:bookref/Models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLoginState extends Equatable {
  MyLoginState([List props = const []]) : super(props);
}

class LoginFinishedState extends MyLoginState {
  final String error;
  final String data;

  LoginFinishedState({@required this.data, this.error});
}

class RegisterFinishedState extends MyLoginState {
  final String error;

  RegisterFinishedState({this.error});
}
