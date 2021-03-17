import 'package:bookref/Models/testbook.dart';
import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/navigation/navigation_bloc.dart';
import 'package:bookref/blocs/navigation/navigation_event.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/services/data_service.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddBookPage extends StatefulWidget {
  @override
  __AddBookPageState createState() => __AddBookPageState();
}

class __AddBookPageState extends State<AddBookPage> {
  DataService dataService;

  @override
  void initState() {
    dataService = new DataService();
    super.initState();
  }

  final identifierInputController = TextEditingController();
  final titleInputController = TextEditingController();
  final subtitleInputController = TextEditingController();
  final authorInputController = TextEditingController();
  String slectedBookId;
  String statusValue = 'ACTIVE';
  bool isExisting = true;
  final TextEditingController _typeAheadController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  "ADD NEW BOOK",
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                )),
            body: Container(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: 950,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
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
                            padding: 0,
                            autoWidth: false,
                            enableButtonWrap: true,
                            wrapAlignment: WrapAlignment.center,
                            spacing: 27.0,
                          ),
                          SizedBox(height: 25),
                          isExisting
                              ? TypeAheadFormField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: this._typeAheadController,
                                    autofocus: false,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                      labelText: 'Select your book',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await dataService
                                        .getBooksByName(pattern);
                                  },
                                  itemBuilder:
                                      (context, DetailsBook suggestion) {
                                    return ListTile(
                                      tileColor: Colors.grey[600],
                                      leading: Icon(
                                        Icons.book,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        suggestion.getBookTitle(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        suggestion.getAuthor() ?? "None",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  },
                                  onSuggestionSelected:
                                      (DetailsBook suggestion) {
                                    // PopUp
                                    this._typeAheadController.text =
                                        suggestion.getBookTitle();
                                    setState(() {
                                      this.slectedBookId = suggestion.getId();
                                    });
                                  },
                                  validator: (value) => value.isEmpty
                                      ? 'Please select a book'
                                      : null,
                                  noItemsFoundBuilder: (context) {
                                    return ListTile(
                                      subtitle: FlatButton(
                                        onPressed: () {
                                          isExisting = false;
                                          setState(() {
                                            this.titleInputController.text =
                                                this._typeAheadController.text;
                                            this.isExisting = false;
                                          });
                                        },
                                        child: Text("Create new book!"),
                                      ),
                                    );
                                  },
                                )
                              : Column(
                                  children: [
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: identifierInputController,
                                      onEditingComplete: () => node.nextFocus(),
                                      decoration: InputDecoration(
                                        hintText: '978-3-7657-1111-4',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        labelText: "Identifier/ ISBN",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0),
                                        ),
                                      ),
                                      validator: (value) => value.isEmpty
                                          ? 'Identifier/ ISBN is required'
                                          : null,
                                    ),
                                    SizedBox(height: 25),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: titleInputController,
                                      onEditingComplete: () => node.nextFocus(),
                                      decoration: InputDecoration(
                                        hintText: 'Protect the Planet',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        labelText: "Title",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0),
                                        ),
                                      ),
                                      validator: (value) => value.isEmpty
                                          ? 'Title is required'
                                          : null,
                                    ),
                                    SizedBox(height: 25),
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      controller: subtitleInputController,
                                      onEditingComplete: () => node.nextFocus(),
                                      decoration: InputDecoration(
                                        hintText: 'World Book',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        labelText: "Subtitle",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: authorInputController,
                                      onEditingComplete: () => node.unfocus(),
                                      decoration: InputDecoration(
                                        hintText: 'Jess French',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        labelText: "Author",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1.0),
                                        ),
                                      ),
                                      validator: (value) => value.isEmpty
                                          ? 'Author is required'
                                          : null,
                                    )
                                  ],
                                ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      BlocProvider.of<AddBookBloc>(context).add(
                                          AddBookButtonPressed(
                                              status: statusValue,
                                              id: slectedBookId,
                                              identifier:
                                                  identifierInputController
                                                      .text,
                                              title: titleInputController.text,
                                              subtitle:
                                                  subtitleInputController.text,
                                              author:
                                                  authorInputController.text));

                                      BlocProvider.of<NotificationBloc>(context)
                                          .add(PushNotification(
                                              status: Colors.green,
                                              title: "Success",
                                              message: "Book was created!"));

                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(ChangeNavigationOnMain(
                                              route: "/dashboard"));

                                      Navigator.of(context).pop();
                                    } catch (err) {
                                      BlocProvider.of<NotificationBloc>(context)
                                          .add(PushNotification(
                                              status: Colors.red,
                                              title: "Error",
                                              message:
                                                  "Some fields are required!"));
                                    }
                                    identifierInputController.clear();
                                    titleInputController.clear();
                                    subtitleInputController.clear();
                                    authorInputController.clear();
                                  }
                                },
                                color: Colors.orange,
                                child: Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      }

      return Text("Error");
    });
  }
}
