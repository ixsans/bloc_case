import 'package:bloccase/bloc/authentication/authentication_bloc.dart';
import 'package:bloccase/bloc/authentication/authentication_state.dart';
import 'package:bloccase/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const SecondPage({Key key, this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: UserRepository()),
      child: SecondPageContent(
        authenticationBloc: authenticationBloc,
      ),
    );
  }
}

class SecondPageContent extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const SecondPageContent({Key key, this.authenticationBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (context, authState) {
            return Container(
              color: Colors.orange,
              child: Center(
                child: Text(
                  authState is AuthenticationSuccessState
                      ? 'Has Logged In'
                      : 'Has not Logged in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
    );
  }
}
