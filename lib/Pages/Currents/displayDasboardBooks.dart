import 'package:bookref/Bloc/currents_bloc/currents_bloc.dart';
import 'package:bookref/Bloc/currents_bloc/currents_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayCurrentsBooks extends StatelessWidget {
  final MyCurrentsBloc bloc;

  const DisplayCurrentsBooks({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCurrentsBloc, MyCurrentsState>(
      cubit: bloc,
      builder: (BuildContext context, MyCurrentsState state) {
        if (state is CurrentBooksLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading ...",
              ),
            ),
          );
        }

        if (state is CurrentBooksNotLoaded) {
          return Text("${state.errors}");
        }

        if (state is CurrentBooksLoaded) {
          final List<Books> currents = state.currents;
          return Text("Hier muss wwas NEues hin!");
        }

        return Text(null);
      },
    );
  }
}
