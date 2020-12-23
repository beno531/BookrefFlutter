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
      document: parseString(queries.readDashboardLibary),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
