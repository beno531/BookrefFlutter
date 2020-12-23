import 'package:bookref/Bloc/libary_bloc/libary_bloc.dart';
import 'package:bookref/Bloc/libary_bloc/libary_events.dart';
import 'package:bookref/Pages/Libary/displayLibaryBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibaryPage extends StatefulWidget {
  @override
  _LibaryPage createState() => _LibaryPage();
}

class _LibaryPage extends State<LibaryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyLibaryBloc>(context).add(LoadMyLibaryBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: new DisplayLibaryBooks(
        bloc: BlocProvider.of<MyLibaryBloc>(context),
      ),
    );
  }
}
