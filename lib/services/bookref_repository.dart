import 'dart:async';

import 'package:bookref/Models/newUser.dart';
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

  Future<QueryResult> registerUser(Map<String, dynamic> params) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(interpolate(queries.registerUser, params)),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  // String preparing for Mutation
  String interpolate(String string, Map<String, dynamic> params) {
    var keys = params.keys;
    String result = string;
    for (var key in keys) {
      result = result.replaceAll('{{$key}}', params[key]);
    }

    print(result);

    return result;
  }
}
