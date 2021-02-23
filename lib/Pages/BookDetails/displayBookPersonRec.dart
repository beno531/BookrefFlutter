import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_bloc.dart';
import 'package:bookref/Bloc/bookDetails_bloc/bookDetails_states.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookref/Bloc/dashboard_bloc/dashboard_current_states.dart';
import 'package:bookref/Models/books.dart';
import 'package:bookref/widgets/bottomNav.dart';
import 'package:bookref/widgets/testNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookref/Pages/Dashboard/buildHorizontalBooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayBookPersonRec extends StatelessWidget {
  final MyBooksDetailsBloc bloc;

  const DisplayBookPersonRec({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBooksDetailsBloc, MyBookDetailsState>(
      cubit: bloc,
      builder: (BuildContext context, MyBookDetailsState state) {
        if (state is LoadingPersonRecState) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading ...",
              ),
            ),
          );
        }

        if (state is PersonRecNotLoadedState) {
          return Text("Error");
        }

        if (state is LoadPersonRecFinishedState) {
          print(state.persons.toString());
          print(state.persons.length);
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.persons.length,
              itemBuilder: (BuildContext context, int index) {
                var title = state.persons[index]['recommendedPerson']['name'] ??
                    "Gerade kein Name da";
                var note =
                    state.persons[index]['note']['content'] ?? "Nix notiert";

                return ListTile(
                  title: Text(title.toString(),
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(note.toString(),
                      style: TextStyle(color: Colors.white)),
                );
              });
        }

        return Text("...");
      },
    );
  }
}
