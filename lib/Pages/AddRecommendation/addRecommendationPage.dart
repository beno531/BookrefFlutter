import 'package:bookref/Bloc/addRecommendation_bloc/addRecommendation_bloc.dart';
import 'package:bookref/Bloc/addRecommendation_bloc/addRecommendation_events.dart';
import 'package:bookref/Bloc/login_bloc/login_bloc.dart';
import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:bookref/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AddRecommendationPage extends StatefulWidget {
  AddRecommendationPage();
  @override
  _AddRecommendationPage createState() => _AddRecommendationPage();
}

final titleInputController = TextEditingController();
final identifierInputController = TextEditingController();
final bookNotesInputController = TextEditingController();

final personInputController = TextEditingController();
final personNotesInputController = TextEditingController();

class _AddRecommendationPage extends State<AddRecommendationPage> {
  _AddRecommendationPage();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyAddRecommendationBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Recommendation View"),
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1.0)),
          child: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 500,
                  child: Container(
                    child: DefaultTabController(
                      length: 2,
                      child: SizedBox(
                        height: 100.0,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              tabs: <Widget>[
                                Tab(
                                  icon: Text('Book',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Tab(
                                  icon: Text('Person',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          TextField(
                                              controller: titleInputController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: 'Title',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          TextField(
                                              controller:
                                                  identifierInputController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: 'Identifier/ ISBN',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          TextField(
                                              controller:
                                                  bookNotesInputController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                labelText: 'Notes',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          SizedBox(height: 15),
                                          SizedBox(height: 20.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: FlatButton(
                                                onPressed: () async {
                                                  BlocProvider.of<
                                                              MyAddRecommendationBloc>(
                                                          context)
                                                      .add(AddBookRecEvent(
                                                          identifier:
                                                              identifierInputController
                                                                  .text,
                                                          title:
                                                              titleInputController
                                                                  .text,
                                                          notes:
                                                              bookNotesInputController
                                                                  .text));
                                                  Toast.show(
                                                      "Finished!", context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.CENTER);

                                                  identifierInputController
                                                      .clear();
                                                  titleInputController.clear();
                                                  bookNotesInputController
                                                      .clear();
                                                },
                                                color: Colors.blue,
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          TextField(
                                              controller: personInputController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: 'Name',
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          TextField(
                                              controller:
                                                  personNotesInputController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                labelText: 'Notes',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          SizedBox(height: 15),
                                          SizedBox(height: 20.0),
                                          SizedBox(
                                            width: double.infinity,
                                            child: FlatButton(
                                                onPressed: () async {
                                                  BlocProvider.of<
                                                              MyAddRecommendationBloc>(
                                                          context)
                                                      .add(AddPersonRecEvent(
                                                          person:
                                                              personInputController
                                                                  .text,
                                                          notes:
                                                              personNotesInputController
                                                                  .text));
                                                  Toast.show(
                                                      "Finished!", context,
                                                      duration:
                                                          Toast.LENGTH_LONG,
                                                      gravity: Toast.CENTER);

                                                  personInputController.clear();
                                                  personNotesInputController
                                                      .clear();
                                                },
                                                color: Colors.blue,
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
