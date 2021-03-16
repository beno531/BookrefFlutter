import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBookPage extends StatefulWidget {
  @override
  __AddBookPageState createState() => __AddBookPageState();
}

class __AddBookPageState extends State<AddBookPage> {
  final identifierInputController = TextEditingController();
  final titleInputController = TextEditingController();
  final subtitleInputController = TextEditingController();
  final authorInputController = TextEditingController();
  String statusValue = 'ACTIVE';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return BlocBuilder<AddBookBloc, AddBookState>(builder: (context, state) {
      //final addBookBloc = BlocProvider.of<AddBookBloc>(context);

      if (state is AddBookLoading) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }

      if (state is AddBookSuccess) {
        // Für später vielleicht mal!
        return Text("Success");
      }

      if (state is AddBookFailure) {
        return Text(state.error);
      }

      if (state is AddBookInitial) {
        return Scaffold(
          appBar: AppBar(
              toolbarHeight: 80.0,
              backgroundColor: Colors.grey[900],
              titleSpacing: 20,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(ChangeNavigationOnMain(route: "/dashboard"));
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "CREATE NEW BOOK",
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              )),
          body: Container(
            decoration: BoxDecoration(color: Colors.grey[800]),
            child:
                Padding(padding: const EdgeInsets.all(8.0), child: Text("dsa")),
          ),
        );
      }

      return Text("Error");
    });
  }
}
