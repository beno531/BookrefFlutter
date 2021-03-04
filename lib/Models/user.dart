import 'package:meta/meta.dart';

class User {
  final String name;
  final String token;

  User({@required this.name, this.token});

  @override
  String toString() => 'User { name: $name, token: $token}';
}
