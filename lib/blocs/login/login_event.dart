import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginInWithEmailButtonPressed(
      {@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterWithEmailButtonPressed extends LoginEvent {
  final String email;
  final String username;
  final String password;

  RegisterWithEmailButtonPressed(
      {@required this.email, @required this.username, @required this.password});

  @override
  List<Object> get props => [email, password];
}
