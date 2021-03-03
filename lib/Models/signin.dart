import 'package:meta/meta.dart';

class SignIn {
  SignIn(this.signin);

  final dynamic signin;

  getToken() => this.signin["book"];

  getErrors() => this.signin["id"];
}
