import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:bookref/services/bookref_graphql_provider.dart' as queries;

class BookrefRepository {
  final GraphQLClient client;

  BookrefRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> getDashboardCurrents() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.readDashboardCurrents),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> getDashboardWishlist() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.readDashboardWishlist),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> getDashboardLibary() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.readDashboardLibrary),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> registerUser(
      String email, String username, String password) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.registerUser),
      variables: {
        'input': {
          'email': '$email',
          'username': '$username',
          'password': '$password'
        }
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> loginUser(String username, String password) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.loginUser),
      variables: {
        'input': {'username': '$username', 'password': '$password'}
      },
    );

    return await client.mutate(_options);
  }
}
