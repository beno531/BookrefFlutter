import 'dart:developer';
import 'package:bookref/models/detailsBook.dart';
import 'package:bookref/blocs/add_book/add_book.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/services/data_service.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        //key: _scaffoldKey,
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Color(0xffE9E8E3)),
        height: size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      left: size.width * 0.03,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'ADD BOOK',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocProvider<AddBookBloc>(
                  create: (context) => AddBookBloc(dataService: DataService()),
                  child: AddBookDisplay(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class AddBookDisplay extends StatefulWidget {
  @override
  __AddBookDisplayState createState() => __AddBookDisplayState();
}

class __AddBookDisplayState extends State<AddBookDisplay> {
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
  String barcode = 'Unknown';

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
        return Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 75, 25, 25),
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
                      ? Column(children: <Widget>[
                          TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: this._typeAheadController,
                              autofocus: false,
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[800]),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: 'Select your book',
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                ),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await dataService.getBooksByName(pattern);
                            },
                            itemBuilder: (context, DetailsBook suggestion) {
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
                            onSuggestionSelected: (DetailsBook suggestion) {
                              // PopUp
                              this._typeAheadController.text =
                                  suggestion.getBookTitle();
                              setState(() {
                                this.slectedBookId = suggestion.getId();
                              });
                            },
                            validator: (value) =>
                                value.isEmpty ? 'Please select a book' : null,
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
                          ),
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey[800],
                                    height: 36,
                                  )),
                            ),
                            Text("OR",
                                style: TextStyle(color: Colors.grey[800])),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 0.0),
                                  child: Divider(
                                    color: Colors.grey[800],
                                    height: 36,
                                  )),
                            ),
                          ]),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: FlatButton(
                                onPressed: () async {
                                  await scanBarcode();

                                  BlocProvider.of<NotificationBloc>(context)
                                      .add(PushNotification(
                                          status: Colors.green,
                                          title: "Success",
                                          message: "Book was created!"));

                                  Navigator.of(context).pop();
                                },
                                color: Colors.blueGrey,
                                child: Text(
                                  'ISBN Scanner',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                )),
                          ),
                        ])
                      : Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.grey[800]),
                              controller: identifierInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: '978-3-7657-1111-4',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                labelText: "Identifier/ ISBN",
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                ),
                              ),
                              validator: (value) => value.isEmpty
                                  ? 'Identifier/ ISBN is required'
                                  : null,
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              style: TextStyle(color: Colors.grey[800]),
                              controller: titleInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: 'Protect the Planet',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                labelText: "Title",
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                ),
                              ),
                              validator: (value) =>
                                  value.isEmpty ? 'Title is required' : null,
                            ),
                            SizedBox(height: 25),
                            TextField(
                              style: TextStyle(color: Colors.grey[800]),
                              controller: subtitleInputController,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: 'World Book',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                labelText: "Subtitle",
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              style: TextStyle(color: Colors.grey[800]),
                              controller: authorInputController,
                              onEditingComplete: () => node.unfocus(),
                              decoration: InputDecoration(
                                hintText: 'Jess French',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                labelText: "Author",
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1.0),
                                ),
                              ),
                              validator: (value) =>
                                  value.isEmpty ? 'Author is required' : null,
                            )
                          ],
                        ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              BlocProvider.of<AddBookBloc>(context).add(
                                  AddBookButtonPressed(
                                      status: statusValue,
                                      id: slectedBookId,
                                      identifier:
                                          identifierInputController.text,
                                      title: titleInputController.text,
                                      subtitle: subtitleInputController.text,
                                      author: authorInputController.text));

                              BlocProvider.of<NotificationBloc>(context).add(
                                  PushNotification(
                                      status: Colors.green,
                                      title: "Success",
                                      message: "Book was created!"));

                              Navigator.pop(context);
                            } catch (err) {
                              log(err.toString());
                              BlocProvider.of<NotificationBloc>(context).add(
                                  PushNotification(
                                      status: Colors.red,
                                      title: "Error",
                                      message: "Some fields are required!"));
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      }

      return Text("Error");
    });
  }

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (!mounted) return;

      BlocProvider.of<AddBookBloc>(context).add(AddBookByIsbnButtonPressed(
          isbn: barcode.toString(), status: statusValue));
    } on PlatformException {
      barcode = 'Failed to get platform version.';
    }
  }
}
