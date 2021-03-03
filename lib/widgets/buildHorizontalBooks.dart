import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_bloc.dart';
import 'package:flutter_bloc_authentication/blocs/dashboard/dashboard_event.dart';
import 'package:flutter_bloc_authentication/models/book.dart';

class BuildHorizontalBooks extends StatelessWidget {
  final List<Book> books;

  BuildHorizontalBooks(this.books);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      child: ListView.builder(
          padding: EdgeInsets.only(right: 25.0),
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Stack(children: <Widget>[
              Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    gradient: new LinearGradient(
                      colors: [Colors.orange[300], Colors.orange[800]],
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(6, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width * 0.41,
                  height: MediaQuery.of(context).size.height * double.infinity,
                  child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.zero,
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      textColor: Colors.black,
                      splashColor: Colors.black12,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed("/bookDetails", arguments: books[index]);
                      },
                      onLongPress: () {
                        var buttonlabels;
                        var buttonValues;
                        var statusValue;

                        switch (books[index].getStatus()) {
                          case "ACTIVE":
                            buttonlabels = [
                              "Wishlist",
                              "Library",
                            ];
                            buttonValues = [
                              "WISH",
                              "DONE",
                            ];
                            break;

                          case "WISH":
                            buttonlabels = [
                              "Currents",
                              "Library",
                            ];
                            buttonValues = [
                              "ACTIVE",
                              "DONE",
                            ];
                            break;

                          case "DONE":
                            buttonlabels = [
                              "Currents",
                              "Wishlist",
                            ];
                            buttonValues = [
                              "ACTIVE",
                              "WISH",
                            ];
                            break;
                          default:
                        }

                        //if (books[index].getBookTitle())
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(5),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey[800]),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 30),
                                        child: Column(
                                          children: [
                                            Text("Move book to:",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center),
                                            SizedBox(height: 25),
                                            CustomRadioButton(
                                              buttonLables: buttonlabels,
                                              buttonValues: buttonValues,
                                              radioButtonValue: (value) {
                                                statusValue = value;
                                              },
                                              selectedColor: Colors.amber,
                                              selectedBorderColor: Colors.amber,
                                              unSelectedColor: Colors.white,
                                              unSelectedBorderColor:
                                                  Colors.white,
                                              padding: 5,
                                              autoWidth: false,
                                              enableButtonWrap: true,
                                              wrapAlignment:
                                                  WrapAlignment.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 35),
                                        child: SizedBox(
                                          width: 200,
                                          child: FlatButton(
                                              onPressed: () {
                                                try {
                                                  BlocProvider.of<
                                                      DashboardBloc>(context)
                                                    ..add(MoveDashboardBook(
                                                        personalBookId:
                                                            books[index]
                                                                .getBookId(),
                                                        newStatus:
                                                            statusValue));

                                                  Flushbar(
                                                    title: "Success!",
                                                    message: "Book was moved!",
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.green,
                                                    margin: EdgeInsets.all(8),
                                                    borderRadius: 8,
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                  )..show(context);
                                                } catch (err) {
                                                  Flushbar(
                                                    title: "Error!",
                                                    message: "Invalid input!",
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor: Colors.red,
                                                    margin: EdgeInsets.all(8),
                                                    borderRadius: 8,
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                  )..show(context);
                                                }

                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              color: Colors.orange,
                                              child: Text(
                                                'CONFIRM',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${books[index].getBookTitle()}",
                                maxLines: 4,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                    color: Colors.white),
                                textAlign: TextAlign.left),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${books[index].getAuthor()}",
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                      color: Colors.white))),
                        ],
                      ))),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/addRecommendation",
                        arguments: books[index].getBookId());
                  },
                ),
              ),
            ]);
          }),
    );
  }
}
