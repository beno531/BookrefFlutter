import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConnectionService {
  final storage = new FlutterSecureStorage();

  Future<GraphQLClient> client() async {
    final token = await getToken();

    HttpLink _httpLink = HttpLink('https://bookref-api-dev.mi5u.de/graphql/',
        defaultHeaders: <String, String>{
          'Authorization': 'Bearer $token',
        });

    //return GraphQLClient(link: _httpLink, cache: GraphQLCache(store: InMemoryStore()));

    return GraphQLClient(
      defaultPolicies: DefaultPolicies(
          query: Policies(
              fetch: FetchPolicy.cacheAndNetwork, error: ErrorPolicy.all),
          mutate:
              Policies(fetch: FetchPolicy.networkOnly, error: ErrorPolicy.all)),
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _httpLink,
    );
  }

  Future<String> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String> setToken(String token) async {
    await storage.write(key: "token", value: token);
    return token;
  }
}
