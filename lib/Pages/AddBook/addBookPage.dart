import 'package:bookref/Bloc/addBook_bloc%20copy/addBook_bloc.dart';
import 'package:bookref/Bloc/addBook_bloc%20copy/addBook_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:toast/toast.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPage createState() => _AddBookPage();
}

final identifierInputController = TextEditingController();
final titleInputController = TextEditingController();
final subtitleInputController = TextEditingController();
final authorInputController = TextEditingController();

final statusItems = ['ACTIVE', 'WISH', 'DONE'];
String dropdownValue = 'ACTIVE';

class _AddBookPage extends State<AddBookPage> {
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  //ExampleNumber selectedNumber;
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];

  static const String appTitle = "Search Choices demo";
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void initState() {
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CREATE A NEW BOOK",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      /*Icon(
                        Icons.cancel,
                        color: Colors.white,
                      )*/
                    ],
                  )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 35),
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: TextStyle(color: Colors.red),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: statusItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextField(
                          style: TextStyle(color: Colors.grey),
                          controller: identifierInputController,
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
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            onPressed: () {
                              BlocProvider.of<MyAddBookBloc>(context).add(
                                  AddBookEvent(
                                      status: dropdownValue,
                                      identifier:
                                          identifierInputController.text,
                                      title: titleInputController.text,
                                      subtitle: subtitleInputController.text,
                                      author: authorInputController.text));

                              Toast.show("Adding Book!", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);

                              identifierInputController.clear();
                              titleInputController.clear();
                              subtitleInputController.clear();
                              authorInputController.clear();
                            },
                            color: Colors.blue,
                            child: Text(
                              'Erstellen',
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
}
