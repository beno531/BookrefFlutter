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

  Future<QueryResult> addBook(
      String identifier, String title, String subtitle) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.addBook),
      variables: {
        'input': {
          'identifier': '$identifier',
          'title': '$title',
          'subtitle': '$subtitle'
        }
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> moveBookInLibrary(String bookId, String status) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.moveBookInLibrary),
      variables: {
        'input': {'bookId': '$bookId', 'status': '$status'}
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> addNewAuthor(String bookId, String authorName) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.addNewAuthor),
      variables: {
        'input': {'bookId': '$bookId', 'name': '$authorName'}
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> addAuthor(String bookId, String authorId) async {
    final MutationOptions _options = MutationOptions(
      document: parseString(queries.addAuthor),
      variables: {
        'input': {'bookId': '$bookId', 'authorId': '$authorId'}
      },
    );

    return await client.mutate(_options);
  }

  Future<QueryResult> checkAuthorName(String authorName) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.checkAuthorName),
      variables: {'input': authorName},
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
