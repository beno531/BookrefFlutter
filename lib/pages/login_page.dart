import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
import 'package:bookref/pages/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../services/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xffE9E8E3)),
        child: SafeArea(
            minimum: const EdgeInsets.all(0),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                final authBloc = BlocProvider.of<AuthenticationBloc>(context);
                if (state is AuthenticationNotAuthenticated) {
                  return SafeArea(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: RichText(
                                text: new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                    fontSize: 40.0,
                                    fontFamily: 'Amaranth',
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'BOOK',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    new TextSpan(
                                        text: 'REF.',
                                        style: new TextStyle(
                                            color: Colors.orange[700],
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )),
                        ),
                        Expanded(
                          child: Center(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 10, 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Welcome,",
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 10, 0),
                                  child: Text("Sign in to continue!",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey[500])),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 90, 40, 0),
                                  child: Container(
                                      height: 320.0, child: _LoginForm()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 70),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "I'm a new User. ",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Sign Up',
                                                style: TextStyle(
                                                    color: Colors.grey[900]),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/register')),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  );
                }
                if (state is AuthenticationFailure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(state.message),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Retry'),
                        onPressed: () {
                          authBloc.add(AppLoaded());
                        },
                      )
                    ],
                  ));
                }
                // return splash screen
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              },
            )),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.add(LoginInWithEmailButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          BlocProvider.of<NotificationBloc>(context).add(PushNotification(
              status: Colors.red, title: "Error", message: state.error));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Username",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    controller: _usernameController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                    ),
                    obscureText: true,
                    autocorrect: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[600],
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (state is! LoginLoading) {
                            _onLoginButtonPressed();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
