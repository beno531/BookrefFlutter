import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/authentication/authentication.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_bloc.dart';
import 'package:flutter_bloc_authentication/pages/dashboard_page.dart';
import 'package:flutter_bloc_authentication/widgets/bottomNav.dart';
import '../blocs/authentication/authentication.dart';
import '../models/models.dart';
import '../services/services.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _navigatorKey = new GlobalKey<NavigatorState>();
    return Text("dasd");
  }
}
