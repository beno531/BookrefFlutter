import 'package:bookref/blocs/move_book.dart/move_book_state.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_state.dart';
import 'package:bookref/models/book.dart';
import 'package:bookref/blocs/move_book.dart/move_book_bloc.dart';
import 'package:bookref/blocs/move_book.dart/move_book_event.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_bloc.dart';
import 'package:bookref/blocs/remove_book.dart/remove_book_event.dart';
import 'package:bookref/services/data_service.dart';
import 'package:bookref/themes/app_colors.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
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
                    height: 330,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.background),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
                    child: Column(
                      children: [
                        Text("Move book to:",
                            style: TextStyle(
                                fontSize: 24, color: Colors.grey[800]),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 35),
                          child: SizedBox(
                              width: 200,
                              child: BlocProvider(
                                  create: (context) =>
                                      MoveBookBloc(dataService: DataService()),
                                  child:
                                      BlocBuilder<MoveBookBloc, MoveBookState>(
                                          builder: (context, state) {
                                    if (state is MoveBookInitial) {
                                      return SizedBox(
                                        width: 200,
                                        child: FlatButton(
                                            onPressed: () {
                                              try {
                                                BlocProvider.of<MoveBookBloc>(
                                                    context)
                                                  ..add((MoveBook(
                                                      personalBookId:
                                                          book.getId(),
                                                      newStatus: statusValue)));

                                                /*BlocProvider.of<
                                                            NotificationBloc>(
                                                        context)
                                                    .add(PushNotification(
                                                        status: Colors.green,
                                                        title: "Success",
                                                        message:
                                                            "Book was moved!"));*/
                                              } catch (err) {
                                                BlocProvider.of<
                                                            NotificationBloc>(
                                                        context)
                                                    .add(PushNotification(
                                                        status: Colors.red,
                                                        title: "Error",
                                                        message:
                                                            "Invalid action!"));
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
                                      );
                                    }

                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  }))
                              /*,*/
                              ),
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
                          Text("OR", style: TextStyle(color: Colors.grey[800])),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                          child: BlocProvider(
                              create: (context) =>
                                  RemoveBookBloc(dataService: DataService()),
                              child:
                                  BlocBuilder<RemoveBookBloc, RemoveBookState>(
                                      builder: (context, state) {
                                if (state is RemoveBookInitial) {
                                  return SizedBox(
                                    width: 200,
                                    child: FlatButton(
                                        onPressed: () {
                                          BlocProvider.of<RemoveBookBloc>(
                                              context)
                                            ..add((RemoveBook(
                                                personalBookId: book.getId())));

                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        color: Colors.red,
                                        child: Text(
                                          'DELETE',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  );
                                }

                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
