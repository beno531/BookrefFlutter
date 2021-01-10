import 'package:bookref/Bloc/login_bloc/login_bloc.dart';
import 'package:bookref/Bloc/login_bloc/login_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

final userLoginInputController = TextEditingController();
final passwordLoginInputController = TextEditingController();

final emailRegisterInputController = TextEditingController();
final userRegisterInputController = TextEditingController();
final passwordRegisterInputController = TextEditingController();

class _LoginPage extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: 440,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 100.0,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          tabs: <Widget>[
                            Tab(
                              icon: Text('Registration',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600])),
                            ),
                            Tab(
                              icon: Text('Login',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600])),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Registration',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[850]),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        controller:
                                            emailRegisterInputController,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Email',
                                          prefixIcon: const Icon(
                                            Icons.mail,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        controller: userRegisterInputController,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Username',
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      TextField(
                                        controller:
                                            passwordRegisterInputController,
                                        obscureText: true,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Password',
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FlatButton(
                                            onPressed: () async {
                                              BlocProvider.of<MyLoginBloc>(
                                                      context)
                                                  .add(RegisterEvent(
                                                      email:
                                                          emailRegisterInputController
                                                              .text,
                                                      username:
                                                          userRegisterInputController
                                                              .text,
                                                      password:
                                                          passwordRegisterInputController
                                                              .text));
                                              Toast.show(
                                                  "Registration finished!",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.CENTER);

                                              emailRegisterInputController
                                                  .clear();
                                              userRegisterInputController
                                                  .clear();
                                              passwordRegisterInputController
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[850]),
                                      ),
                                      SizedBox(height: 15),
                                      TextField(
                                        controller: userLoginInputController,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Username',
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      TextField(
                                        controller:
                                            passwordLoginInputController,
                                        obscureText: true,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Password',
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FlatButton(
                                            onPressed: () async {
                                              BlocProvider.of<MyLoginBloc>(
                                                      context)
                                                  .add(LoginEvent(
                                                      username:
                                                          userLoginInputController
                                                              .text,
                                                      password:
                                                          passwordLoginInputController
                                                              .text));
                                              Navigator.pushReplacementNamed(
                                                  context, "/home");

                                              Toast.show(
                                                  "Login finished!", context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.CENTER);

                                              userLoginInputController.clear();
                                              passwordLoginInputController
                                                  .clear();
                                            },
                                            color: Colors.blue,
                                            child: Text(
                                              'Login',
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
        )),
      ),
    );
  }
}
