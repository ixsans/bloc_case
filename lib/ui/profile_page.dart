import 'package:bloccase/bloc/authentication/authentication_bloc.dart';
import 'package:bloccase/bloc/authentication/authentication_event.dart';
import 'package:bloccase/bloc/authentication/authentication_state.dart';
import 'package:bloccase/bloc/login/login_bloc.dart';
import 'package:bloccase/bloc/login/login_event.dart';
import 'package:bloccase/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  //final AuthenticationBloc authenticationBloc;

  /* const ProfilePage({Key key, @required this.authenticationBloc})
      : super(key: key);*/

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProfileContentPage(
            /*authenticationBloc: widget.authenticationBloc,*/
            ));
  }
}

class ProfileContentPage extends StatelessWidget {
  //final AuthenticationBloc authenticationBloc;

  //const ProfileContentPage({Key key, this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (ctx, loginState) {
        if (loginState is AuthenticationLoadingState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logout...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        } else if (loginState is AuthenticationFailureState) {
          //trigger auth bloc
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedOut());

          //redirect to main and clear route stacks
          Navigator.pushNamedAndRemoveUntil(context, "/main", (r) => false);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('PROFILE PAGE'),
              SizedBox(
                height: 100,
              ),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoggedOut());
                },
                child: Text('Logout'),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
