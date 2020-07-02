import 'package:bloccase/bloc/authentication/authentication_bloc.dart';
import 'package:bloccase/bloc/authentication/authentication_event.dart';
import 'package:bloccase/bloc/authentication/authentication_state.dart';
import 'package:bloccase/ui/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const MainPage({Key key, this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        builder: (context, authState) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('MAIN PAGE'),
                    SizedBox(height: 20),
                    (authState is AuthenticationLoadingState)
                        ? CircularProgressIndicator()
                        : SizedBox(),
                    Text(authState is AuthenticationLoggedIn
                        ? 'Logged In'
                        : 'Not logged in'),
                    SizedBox(height: 100),
                    RaisedButton(
                        onPressed: () {
                          if (authState is AuthenticationLoggedIn) {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(AuthenticationLoggedOut());
                          } else {
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        child: Text(authState is AuthenticationLoggedIn
                            ? 'Logout'
                            : 'Open Login Page')),
                    /*RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage(
                                      authenticationBloc:
                                          BlocProvider.of<AuthenticationBloc>(
                                              context),
                                    )));
                      },
                      child: Text('Second Page'),
                    )*/
                  ],
                ),
              ),
            ),
          );
        });
  }
}
