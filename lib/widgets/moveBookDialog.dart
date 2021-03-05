import 'package:bookref/Models/book.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_event.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveBookDialog {
  show(Book book, BuildContext context) {
    var buttonlabels;
    var buttonValues;
    var statusValue;

    switch (book.getStatus()) {
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
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[800]),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
                    child: Column(
                      children: [
                        Text("Move book to:",
                            style: TextStyle(fontSize: 24, color: Colors.white),
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
                          unSelectedBorderColor: Colors.white,
                          padding: 5,
                          autoWidth: false,
                          enableButtonWrap: true,
                          wrapAlignment: WrapAlignment.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 35),
                    child: SizedBox(
                      width: 200,
                      child: FlatButton(
                          onPressed: () {
                            try {
                              BlocProvider.of<MoveBookBloc>(context)
                                ..add((MoveBook(
                                    personalBookId: book.getId(),
                                    newStatus: statusValue)));

                              Flushbar(
                                title: "Success!",
                                message: "Book was moved!",
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                                margin: EdgeInsets.all(8),
                                borderRadius: 8,
                                flushbarPosition: FlushbarPosition.TOP,
                              )..show(context);
                            } catch (err) {
                              Flushbar(
                                title: "Error!",
                                message: "Invalid input!",
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.all(8),
                                borderRadius: 8,
                                flushbarPosition: FlushbarPosition.TOP,
                              )..show(context);
                            }

                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          color: Colors.orange,
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ));
        });
  }
}
