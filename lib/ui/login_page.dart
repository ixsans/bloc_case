import 'package:bloccase/bloc/authentication/authentication_bloc.dart';
import 'package:bloccase/bloc/authentication/authentication_event.dart';
import 'package:bloccase/bloc/authentication/authentication_state.dart';
import 'package:bloccase/bloc/login/login_bloc.dart';
import 'package:bloccase/bloc/login/login_event.dart';
import 'package:bloccase/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const LoginPage({Key key, @required this.authenticationBloc})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginForm(
      authenticationBloc: widget.authenticationBloc,
    ));
  }
}

class LoginForm extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const LoginForm({Key key, this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<LoginBloc, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (ctx, loginState) {
        if (loginState is LoginSuccessState) {
          //trigger auth bloc
          authenticationBloc.add(AuthenticationLoggedIn(loginState.token));

          //redirect to main and clear route stacks
          Navigator.pushNamedAndRemoveUntil(context, "/main", (r) => false);
        } else if (loginState is LoginLoadingState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('LOGIN PAGE'),
            SizedBox(
              height: 100,
            ),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(LoginButtonPressed(email: 'admin', password: 'admin'));
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    ));
  }
}
