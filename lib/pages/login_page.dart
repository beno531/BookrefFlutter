import 'package:bookref/blocs/notification/notification_bloc.dart';
import 'package:bookref/blocs/notification/notification_event.dart';
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
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                final authBloc = BlocProvider.of<AuthenticationBloc>(context);
                if (state is AuthenticationNotAuthenticated) {
                  return SafeArea(
                    child: Center(
                        child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[900]),
                        child: DefaultTabController(
                          length: 2,
                          child: SizedBox(
                            height: 690.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/icon/new_bookref_icon.svg",
                                  semanticsLabel: 'Bookref Logo',
                                  height: 128,
                                  color: Colors.orange.shade400,
                                ),
                                SizedBox(
                                  height: 100.0,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TabBar(
                                    tabs: <Widget>[
                                      Tab(
                                        icon: Text('Login',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Tab(
                                        icon: Text('Registration',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [_LoginForm()],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [_RegisterForm()],
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
                    )),
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

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: _SignUpForm(),
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
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
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
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
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
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (state is! LoginLoading) {
                            _onLoginButtonPressed();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("LOG IN"),
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

class _SignUpForm extends StatefulWidget {
  @override
  __SignUpFormState createState() => __SignUpFormState();
}

class __SignUpFormState extends State<_SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.add(RegisterWithEmailButtonPressed(
          email: _emailController.text,
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
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
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
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
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
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (state is! LoginLoading) {
                            _onLoginButtonPressed();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("SIGN UP"),
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
