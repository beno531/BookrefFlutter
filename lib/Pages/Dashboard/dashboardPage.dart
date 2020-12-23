import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_events.dart';
import 'package:bookref/Pages/Dashboard/displayDasboardBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyDashboardBloc>(context).add(LoadMyDashboardBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: new DisplayDashboardBooks(
        bloc: BlocProvider.of<MyDashboardBloc>(context),
      ),
    );
  }
}
