import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<MyLibraryBloc>(context).add(LoadMyLibraryBooks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    return Text(args.toString());
  }
}
