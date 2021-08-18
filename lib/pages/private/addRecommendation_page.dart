import 'package:bookref/models/detailsBook.dart';
import 'package:bookref/blocs/add_recommendation.dart/add_recommendation.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/services/data_service.dart';
import 'package:bookref/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddRecommendationPage extends StatelessWidget {
  String bookId;

  AddRecommendationPage(String bookId) {
    this.bookId = bookId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddRecommendationBloc(
            dataService: DataService(), bookId: this.bookId),
        child: AddRecommendationPageDisplay());
  }
}

class AddRecommendationPageDisplay extends StatefulWidget {
  @override
  __AddRecommendationPageDisplayState createState() =>
      __AddRecommendationPageDisplayState();
}

class __AddRecommendationPageDisplayState
    extends State<AddRecommendationPageDisplay> {
  DataService dataService;

  @override
  void initState() {
    dataService = new DataService();
    super.initState();
  }

  final titleInputController = TextEditingController();
  final identifierInputController = TextEditingController();
  final bookNotesInputController = TextEditingController();
  final subtitleInputController = TextEditingController();
  final authorInputController = TextEditingController();

  final personInputController = TextEditingController();
  final personNotesInputController = TextEditingController();

  bool isExisting = true;
  final TextEditingController _typeAheadController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String slectedBookId;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return BlocBuilder<AddRecommendationBloc, AddRecommendationState>(
        builder: (context, state) {
      final recommendationBloc =
          BlocProvider.of<AddRecommendationBloc>(context);
      if (state is AddRecommendationInitial) {
        final size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
              title: Text("Add Recommendation",
                  style: TextStyle(color: Colors.grey[800])),
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.grey[800],
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              decoration: BoxDecoration(color: AppColors.background),
              child: DefaultTabController(
                length: 2,
                child: SafeArea(
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
                                          color: Colors.grey[800])),
                                ),
                                Tab(
                                  icon: Text('Person',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800])),
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 35, 20, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              isExisting
                                                  ? TypeAheadFormField(
                                                      textFieldConfiguration:
                                                          TextFieldConfiguration(
                                                        controller: this
                                                            ._typeAheadController,
                                                        autofocus: false,
                                                        style: DefaultTextStyle
                                                                .of(context)
                                                            .style
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey[800]),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey[800],
                                                                width: 1.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .orange,
                                                                    width: 1.0),
                                                          ),
                                                        ),
                                                      ),
                                                      suggestionsCallback:
                                                          (pattern) async {
                                                        return await dataService
                                                            .getBooksByName(
                                                                pattern);
                                                      },
                                                      itemBuilder: (context,
                                                          DetailsBook
                                                              suggestion) {
                                                        return ListTile(
                                                          tileColor:
                                                              Colors.white,
                                                          leading: Icon(
                                                            Icons.book,
                                                            color: Colors
                                                                .grey[800],
                                                          ),
                                                          title: Text(
                                                            suggestion
                                                                .getBookTitle(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                          ),
                                                          subtitle: Text(
                                                            suggestion
                                                                    .getAuthor() ??
                                                                "None",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                          ),
                                                        );
                                                      },
                                                      onSuggestionSelected:
                                                          (DetailsBook
                                                              suggestion) {
                                                        // PopUp
                                                        this
                                                                ._typeAheadController
                                                                .text =
                                                            suggestion
                                                                .getBookTitle();
                                                        setState(() {
                                                          this.slectedBookId =
                                                              suggestion
                                                                  .getId();
                                                        });
                                                      },
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? 'Please select a book'
                                                          : null,
                                                      noItemsFoundBuilder:
                                                          (context) {
                                                        return ListTile(
                                                          subtitle: FlatButton(
                                                            onPressed: () {
                                                              isExisting =
                                                                  false;
                                                              setState(() {
                                                                this
                                                                        .titleInputController
                                                                        .text =
                                                                    this
                                                                        ._typeAheadController
                                                                        .text;
                                                                this.isExisting =
                                                                    false;
                                                              });
                                                            },
                                                            child: Text(
                                                                "Create new book!"),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Column(
                                                      children: [
                                                        TextFormField(
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
                                                          controller:
                                                              identifierInputController,
                                                          onEditingComplete:
                                                              () => node
                                                                  .nextFocus(),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                '978-3-7657-1111-4',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[500]),
                                                            labelText:
                                                                "Identifier/ ISBN",
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange,
                                                                  width: 1.0),
                                                            ),
                                                          ),
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'Identifier/ ISBN is required'
                                                                  : null,
                                                        ),
                                                        SizedBox(height: 25),
                                                        TextFormField(
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
                                                          controller:
                                                              titleInputController,
                                                          onEditingComplete:
                                                              () => node
                                                                  .nextFocus(),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Protect the Planet',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[500]),
                                                            labelText: "Title",
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange,
                                                                  width: 1.0),
                                                            ),
                                                          ),
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'Title is required'
                                                                  : null,
                                                        ),
                                                        SizedBox(height: 25),
                                                        TextField(
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
                                                          controller:
                                                              subtitleInputController,
                                                          onEditingComplete:
                                                              () => node
                                                                  .nextFocus(),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'World Book',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[500]),
                                                            labelText:
                                                                "Subtitle",
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange,
                                                                  width: 1.0),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 25),
                                                        TextFormField(
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800]),
                                                          controller:
                                                              authorInputController,
                                                          onEditingComplete:
                                                              () => node
                                                                  .unfocus(),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Jess French',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[500]),
                                                            labelText: "Author",
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[800]),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .orange,
                                                                  width: 1.0),
                                                            ),
                                                          ),
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'Author is required'
                                                                  : null,
                                                        )
                                                      ],
                                                    ),
                                              SizedBox(height: 25),
                                              TextField(
                                                controller:
                                                    bookNotesInputController,
                                                maxLines: 5,
                                                style: TextStyle(
                                                    color: Colors.grey[800]),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'I like this book...',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey[700]),
                                                  labelText: "Notes",
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey[800]),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.orange,
                                                        width: 1.0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20.0),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: FlatButton(
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        try {
                                                          recommendationBloc.add(AddBookRecommendationButtonPressed(
                                                              id: this
                                                                  .slectedBookId,
                                                              identifier:
                                                                  identifierInputController
                                                                      .text,
                                                              title:
                                                                  titleInputController
                                                                      .text,
                                                              subtitle:
                                                                  subtitleInputController
                                                                      .text,
                                                              author:
                                                                  authorInputController
                                                                      .text,
                                                              notes:
                                                                  bookNotesInputController
                                                                      .text));

                                                          BlocProvider.of<
                                                                      NotificationBloc>(
                                                                  context)
                                                              .add(PushNotification(
                                                                  status: Colors
                                                                      .green,
                                                                  title:
                                                                      "Success",
                                                                  message:
                                                                      "Recommendation was created!"));

                                                          Navigator.pop(
                                                              context);
                                                        } catch (err) {
                                                          BlocProvider.of<
                                                                      NotificationBloc>(
                                                                  context)
                                                              .add(PushNotification(
                                                                  status: Colors
                                                                      .red,
                                                                  title:
                                                                      "Error",
                                                                  message: err
                                                                          .message ??
                                                                      "Some fields are required!"));
                                                        }
                                                      }
                                                    },
                                                    color: Colors.green,
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
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextField(
                                              controller: personInputController,
                                              onEditingComplete: () =>
                                                  node.unfocus(),
                                              style: TextStyle(
                                                  color: Colors.grey[800]),
                                              decoration: InputDecoration(
                                                hintText: 'Albert Einstein',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                labelText: "Name",
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange,
                                                      width: 1.0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            TextField(
                                              controller:
                                                  personNotesInputController,
                                              maxLines: 5,
                                              style: TextStyle(
                                                  color: Colors.grey[800]),
                                              decoration: InputDecoration(
                                                hintText:
                                                    'I like this person...',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                labelText: "Notes",
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange,
                                                      width: 1.0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(height: 20.0),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 50,
                                              child: FlatButton(
                                                  onPressed: () async {
                                                    try {
                                                      recommendationBloc.add(
                                                          AddPersonRecommendationButtonPressed(
                                                              person:
                                                                  personInputController
                                                                      .text,
                                                              notes:
                                                                  personNotesInputController
                                                                      .text));

                                                      BlocProvider.of<
                                                                  NotificationBloc>(
                                                              context)
                                                          .add(PushNotification(
                                                              status:
                                                                  Colors.green,
                                                              title: "Success",
                                                              message:
                                                                  "Recommendation was created!"));
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              "/currents");
                                                    } catch (err) {
                                                      BlocProvider.of<
                                                                  NotificationBloc>(
                                                              context)
                                                          .add(PushNotification(
                                                              status:
                                                                  Colors.red,
                                                              title: "Error",
                                                              message: err
                                                                      .message ??
                                                                  "Some fields are required!"));
                                                    }

                                                    personInputController
                                                        .clear();
                                                    personNotesInputController
                                                        .clear();
                                                  },
                                                  color: Colors.green,
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
        );
      }
      if (state is AddRecommendationFailure) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Text(state.message),
            Text("Error"),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text('Retry'),
              onPressed: () {
                //authBloc.add(AppLoaded());
              },
            )
          ],
        ));
      }

      if (state is AddRecommendationLoading) {
        return Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }
      // return splash screen
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    });
  }
}
