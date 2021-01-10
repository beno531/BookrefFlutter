import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLoginEvent extends Equatable {
  MyLoginEvent([List props = const []]) : super(props);
}

class RegisterEvent extends MyLoginEvent {
  final String email;
  final String username;
  final String password;

  RegisterEvent(
      {@required this.email, @required this.username, @required this.password})
      : assert(email.isEmpty == false &&
            username.isEmpty == false &&
            password.isEmpty == false);
}

class LoginEvent extends MyLoginEvent {
  final String username;
  final String password;

  LoginEvent({@required this.username, @required this.password})
      : assert(username.isEmpty == false && password.isEmpty == false);
}
