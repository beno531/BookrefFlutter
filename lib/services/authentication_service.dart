import 'package:bookref/repositories/repositories.dart';
import 'package:bookref/services/connection_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'package:graphql/client.dart';
import '../exceptions/exceptions.dart';
import '../models/models.dart';

class AuthenticationService {
  BookrefRepository _bookrefRepository;
  UserRepository _userRepository;
  ConnectionService _connectionService;

  AuthenticationService() {
    _bookrefRepository = BookrefRepository();
    _userRepository = UserRepository();
    _connectionService = ConnectionService();
  }

  Future<User> getCurrentUser() async {
    try {
      return User(
          name: await _userRepository.getUsername(),
          token: await _connectionService.getToken());
    } catch (e) {
      return User(name: "", token: "");
    }
  }

  Future<User> signIn(String username, String password) async {
    QueryResult signinResult =
        await _bookrefRepository.loginUser(username, password);

    if (signinResult.data['singIn']['errors'] != null) {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    await _connectionService.setToken(signinResult.data['singIn']['data']);
    await _userRepository.setUsername(username);

    return User(name: "username", token: signinResult.data['singIn']['data']);
  }

  Future<User> signUp(String email, String username, String password) async {
    final result =
        await _bookrefRepository.registerUser(email, username, password);

    QueryResult signinResult;

    if (result != null) {
      signinResult = await _bookrefRepository.loginUser(username, password);

      if (signinResult.data['singIn']['errors'] != null) {
        throw AuthenticationException(message: 'Wrong username or password');
      }
      await _connectionService.setToken(signinResult.data['singIn']['data']);
      await _userRepository.setUsername(username);
    }

    return User(name: "username", token: signinResult.data['singIn']['data']);
  }

  Future<void> signOut() async {
    await _connectionService.setToken("");
    await _userRepository.setUsername("");
    return null;
  }
}
