import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();

  Future<String> getUsername() async {
    return await storage.read(key: "username");
  }

  Future<String> setUsername(String username) async {
    await storage.write(key: "username", value: username);
    return username;
  }
}
