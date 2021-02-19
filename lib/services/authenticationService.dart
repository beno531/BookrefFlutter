import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  final storage = new FlutterSecureStorage();
  String token;

  AuthenticationService() {
    this.token = _getToken();
  }

  _getToken() async {
    return await storage.read(key: "token");
  }

  bool checkToken() {
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
