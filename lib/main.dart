import 'package:bookref/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/dashboard',
    routes: {
      '/dashboard': (context) => Dashboard(),
    },
  ));
}
