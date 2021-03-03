import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/add_book/add_book.dart';
import 'package:flutter_bloc_authentication/models/models.dart';
import 'package:toast/toast.dart';

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
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
                    child: Text(
                      "CREATE A NEW BOOK",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 5, 25, 35),
                      child: Column(
                        children: <Widget>[
                          CustomRadioButton(
                            buttonLables: [
                              "Currents",
                              "Wishlist",
                              "Library",
                            ],
                            buttonValues: [
                              "ACTIVE",
                              "WISH",
                              "DONE",
                            ],
                            defaultSelected: "ACTIVE",
                            radioButtonValue: (value) {
                              setState(() {
                                statusValue = value;
                              });
                            },
                            selectedColor: Colors.orange,
                            selectedBorderColor: Colors.orange,
                            unSelectedColor: Colors.white,
                            unSelectedBorderColor: Colors.white,
                            padding: 5,
                            autoWidth: false,
                            enableButtonWrap: true,
                            wrapAlignment: WrapAlignment.center,
                          ),
                          TextField(
                              style: TextStyle(color: Colors.grey),
                              controller: identifierInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'Identifier',
                                labelStyle: TextStyle(color: Colors.white),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              )),
                          TextField(
                              style: TextStyle(color: Colors.grey),
                              controller: titleInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(color: Colors.white),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              )),
                          TextField(
                              style: TextStyle(color: Colors.grey),
                              controller: subtitleInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'Subtitle',
                                labelStyle: TextStyle(color: Colors.white),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              )),
                          TextField(
                              style: TextStyle(color: Colors.grey),
                              controller: authorInputController,
                              onEditingComplete: () => node.unfocus(),
                              decoration: InputDecoration(
                                labelText: 'Author',
                                labelStyle: TextStyle(color: Colors.white),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              )),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                                onPressed: () {
                                  try {
                                    BlocProvider.of<AddBookBloc>(context).add(
                                        AddBookButtonPressed(
                                            status: statusValue,
                                            identifier:
                                                identifierInputController.text,
                                            title: titleInputController.text,
                                            subtitle:
                                                subtitleInputController.text,
                                            author:
                                                authorInputController.text));

                                    _showSuccess("Book added!");
                                  } catch (err) {
                                    _showError(err.message ??
                                        "Some fields are required!");
                                  }

                                  identifierInputController.clear();
                                  titleInputController.clear();
                                  subtitleInputController.clear();
                                  authorInputController.clear();
                                },
                                color: Colors.orange,
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  void _showError(String error) {
    Flushbar(
      title: "Error!",
      message: error,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void _showSuccess(String message) {
    Flushbar(
      title: "Success!",
      message: message,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}
