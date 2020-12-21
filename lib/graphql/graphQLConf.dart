import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    "https://bookref-api-dev.mi5u.de/graphql/",
  );

  /*
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: InMemoryCache(),
    ),
  );
  */

  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      'https://api.github.com/graphql',
    );

    /*
    final AuthLink _authLink = AuthLink(
      getToken: () => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
    );
    */

    //final Link _link = _authLink.concat(_httpLink);
    final Link _link = _httpLink;

    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _link,
    );
  }
}
