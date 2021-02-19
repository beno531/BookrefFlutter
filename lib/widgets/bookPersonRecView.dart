import 'package:bookref/Models/books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookPersonRecView extends StatefulWidget {
  Map<String, dynamic> arguments;
  BookPersonRecView(this.arguments);

  @override
  _BookPersonRecView createState() => _BookPersonRecView(this.arguments);
}

class _BookPersonRecView extends State<BookPersonRecView> {
  Map<String, dynamic> arguments;

  _BookPersonRecView(this.arguments);

  @override
  Widget build(BuildContext context) {
    final Books books = arguments['book'];

    print(arguments['book']);

    return Scaffold(
      appBar: AppBar(
        title: Text("BookPersonRecView"),
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Container(
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
      )),
    );
  }
}
