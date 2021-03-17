import 'package:bookref/Models/testbook.dart';
import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TestPage extends StatelessWidget {
  DataService dataService;
  TestPage() {
    dataService = new DataService();
  }

  // Will print error messages to the console.
  final String assetName = 'assets/icon/new_bookref_icon.svg';

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      assetName,
    );
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        //SvgPicture.asset("assets/Newbookref_icon.svg",semanticsLabel: 'Acme Logo'),
        //SvgPicture.asset("assets/icon/bookref_icon.svg",semanticsLabel: 'Acme Logo'),
        svg,
        SvgPicture.network(
          'https://www.svgrepo.com/show/2046/dog.svg',
          placeholderBuilder: (context) => CircularProgressIndicator(),
          height: 128.0,
        ),
      ],
    )));

    // return BlocBuilder<BookDetailsBloc, BookDetailsState>(
    //     builder: (context, state) {
    //   //final bookDetailsBloc = BlocProvider.of<BookDetailsBloc>(context);

    //   return Text("Error");
    // });
  }
}
