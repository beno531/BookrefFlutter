import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Pages/Currents/currentsPage.dart';
import 'package:bookref/Pages/Dashboard/dashboardPage.dart';
import 'package:bookref/graphql/graphQLConf.dart';
import 'package:bookref/services/bookref_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookref.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/currents",
      routes: {
        '/dashboard': (_) => BlocProvider(
              create: (context) => MyDashboardBloc(
                bookrefRepository: BookrefRepository(
                  client: _client(),
                ),
              ),
              child: DashboardPage(),
            ),
        '/currents': (_) => BlocProvider(
              create: (context) => MyCurrentsBloc(
                bookrefRepository: BookrefRepository(
                  client: _client(),
                ),
              ),
              child: CurrentsPage(),
            ),
      },
    );
  }

  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      'https://bookref-api-dev.mi5u.de/graphql/',
    );

    final Link _link = _httpLink;

    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _link,
    );
  }
}
