import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  String title;
  String subtitle;

  CustomListTile(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}