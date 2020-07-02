import 'package:bloccase/app_bloc_delegate.dart';
import 'package:bloccase/repository/repository.dart';
import 'package:bloccase/ui/login_page.dart';
import 'package:bloccase/ui/main_page.dart';
import 'package:bloccase/ui/profile_page.dart';
import 'package:bloccase/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_event.dart';
import 'bloc/login/login_bloc.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(userRepository: userRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AuthenticationStarted());
        }),
        BlocProvider(
          create: (context) => LoginBloc(
            userRepository: userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
      ],
      child: MyApp(
          userRepository: userRepository,
          authenticationBloc: authenticationBloc),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  const MyApp({Key key, @required this.userRepository, this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/main': (context) => MainPage(),
        '/login': (context) => LoginPage(
              authenticationBloc: authenticationBloc,
            ),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
