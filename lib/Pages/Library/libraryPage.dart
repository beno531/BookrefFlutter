import 'package:bookref/Bloc/library_bloc/library_bloc.dart';
import 'package:bookref/Bloc/library_bloc/library_events.dart';
import 'package:bookref/Pages/Library/displayLibraryBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPage createState() => _LibraryPage();
}

class _LibraryPage extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyLibraryBloc>(context).add(LoadMyLibraryBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: new DisplayLibraryBooks(
        bloc: BlocProvider.of<MyLibraryBloc>(context),
      ),
    );
  }
}
