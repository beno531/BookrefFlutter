import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication.dart';
import '../models/models.dart';

class NavDrawer extends StatelessWidget {
  User user;
  NavDrawer({@required this.user});
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                Text(
                  '${user.name}',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              /*image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))*/
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {authBloc.add(UserLoggedOut())},
          ),
        ],
      ),
    );
  }
}
