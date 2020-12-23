import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/currents_bloc/currents_events.dart';
import 'package:bookref/Pages/Currents/displayCurrentsBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentsPage extends StatefulWidget {
  @override
  _CurrentsPage createState() => _CurrentsPage();
}

class _CurrentsPage extends State<CurrentsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyCurrentsBloc>(context).add(LoadMyCurrentBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: new DisplayCurrentsBooks(
        bloc: BlocProvider.of<MyCurrentsBloc>(context),
      ),
    );
  }
}
