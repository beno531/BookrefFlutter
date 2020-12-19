import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/pages/dashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GraphQLProvider(
    client: graphQLConfiguration.client,
    child: CacheProvider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => Dashboard(),
      },
    )),
  ));
}
